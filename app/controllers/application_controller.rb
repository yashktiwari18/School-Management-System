class ApplicationController < ActionController::Base
  helper_method :current_admin, :logged_in?
  before_action :check_session_timeout


  private

  def current_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end

  def logged_in?
    current_admin.present?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please login first."
    end
  end


  private

def check_session_timeout
  return unless session[:admin_id]

  if session[:last_seen_at].present? &&
     session[:last_seen_at] < 8.hours.ago

    reset_session

    redirect_to login_path,
      alert: "Your session has expired. Please login again."

    return
  end

  session[:last_seen_at] = Time.current
end
end
