class DashboardController < ApplicationController
  def index
    @user             = current_user
    @recent_tasks     = current_user.tasks.recent.limit(5)
    @pending_tasks    = current_user.tasks.pending.recent.limit(5)
    @completed_today  = current_user.tasks.completed
                                    .where(completed_at: Time.current.beginning_of_day..)
                                    .count
    @total_xp_today   = current_user.tasks.completed
                                    .where(completed_at: Time.current.beginning_of_day..)
                                    .sum(:xp_reward)
    @recent_achievements = current_user.user_achievements
                                       .order(earned_at: :desc)
                                       .includes(:achievement)
                                       .limit(3)
    @stats = {
      total_tasks:     current_user.tasks.count,
      completed_tasks: current_user.tasks.completed.count,
      pending_tasks:   current_user.tasks.pending.count,
      streak_days:     current_user.streak_days
    }
  end
end
