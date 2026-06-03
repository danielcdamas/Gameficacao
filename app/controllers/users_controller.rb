class UsersController < ApplicationController
  skip_before_action :require_authentication, only: [ :new, :create ]
  skip_before_action :set_current_user_theme, only: [ :new, :create ]

  def new
    redirect_to root_path if authenticated?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Conta criada! Bem-vindo ao Gameficação, #{@user.name}! 🎮"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_update_params)
      redirect_to root_path, notice: "Perfil atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :theme, :color_theme)
  end
end
