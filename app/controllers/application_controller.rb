class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def redirect_with_alert
    redirect_to root_path, alert: 'Вам сюда нельзя'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
