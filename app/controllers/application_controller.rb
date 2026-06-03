class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :require_authentication
  before_action :set_current_user_theme

  helper_method :current_user, :authenticated?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticated?
    current_user.present?
  end

  def require_authentication
    redirect_to login_path, alert: "Por favor, faça login." unless authenticated?
  end

  def set_current_user_theme
    return unless current_user

    @theme       = current_user.theme
    @color_theme = current_user.color_theme
  end
end
