class SessionsController < ApplicationController
  skip_before_action :require_authentication, only: [:new, :create]
  skip_before_action :set_current_user_theme, only: [:new, :create]

  def new
    redirect_to root_path if authenticated?
  end

  def create
    user = User.find_by(email: params[:email]&.downcase&.strip)

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Bem-vindo de volta, #{user.name}! 👋"
    else
      flash.now[:alert] = "Email ou senha inválidos."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "Até logo! 👋"
  end
end
