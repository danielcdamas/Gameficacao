class ThemesController < ApplicationController
  def update
    if params[:theme].present? && User::THEMES.include?(params[:theme])
      current_user.update!(theme: params[:theme])
    end

    if params[:color_theme].present? && User::COLOR_THEMES.include?(params[:color_theme])
      current_user.update!(color_theme: params[:color_theme])
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "theme-root",
          partial: "shared/theme_wrapper",
          locals: { theme: current_user.theme, color_theme: current_user.color_theme }
        )
      end
      format.html { redirect_back fallback_location: root_path }
    end
  end
end
