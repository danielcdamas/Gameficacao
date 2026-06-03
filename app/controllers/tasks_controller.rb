class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy, :complete ]

  def index
    @tasks = current_user.tasks
                         .order(completed: :asc, created_at: :desc)
    @tasks = @tasks.where(difficulty: params[:difficulty]) if params[:difficulty].present?
    @tasks = @tasks.where(category: params[:category]) if params[:category].present?
    @tasks = filter_by_status(@tasks)
    @pending_count   = current_user.tasks.pending.count
    @completed_count = current_user.tasks.completed.count
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("tasks-list", partial: "tasks/task", locals: { task: @task }),
            turbo_stream.replace("task-counts", partial: "tasks/counts",
                                 locals: { pending: current_user.tasks.pending.count,
                                           completed: current_user.tasks.completed.count }),
            turbo_stream.replace("new-task-form", partial: "tasks/form",
                                 locals: { task: current_user.tasks.build })
          ]
        end
        format.html { redirect_to tasks_path, notice: "Tarefa criada! +#{@task.xp_reward} XP ao completar." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new-task-form", partial: "tasks/form", locals: { task: @task }), status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    redirect_to tasks_path
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Tarefa atualizada!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove("task-#{@task.id}"),
          turbo_stream.replace("task-counts", partial: "tasks/counts",
                               locals: { pending: current_user.tasks.pending.count,
                                         completed: current_user.tasks.completed.count })
        ]
      end
      format.html { redirect_to tasks_path, notice: "Tarefa removida." }
    end
  end

  def complete
    return redirect_to tasks_path, alert: "Tarefa já concluída." if @task.completed?

    leveled_up = @task.complete!(current_user)
    current_user.reload

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("task-#{@task.id}", partial: "tasks/task", locals: { task: @task }),
          turbo_stream.replace("user-stats", partial: "shared/user_stats", locals: { user: current_user }),
          turbo_stream.replace("task-counts", partial: "tasks/counts",
                               locals: { pending: current_user.tasks.pending.count,
                                         completed: current_user.tasks.completed.count }),
          turbo_stream.replace("xp-notification",
                               partial: "shared/xp_notification",
                               locals: { xp: @task.xp_reward, leveled_up: leveled_up,
                                         level: current_user.level })
        ]
      end
      format.html { redirect_to tasks_path, notice: "Tarefa concluída! +#{@task.xp_reward} XP!" }
    end
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :difficulty, :category, :due_date)
  end

  def filter_by_status(tasks)
    case params[:status]
    when "pending"   then tasks.pending
    when "completed" then tasks.completed
    else tasks
    end
  end
end
