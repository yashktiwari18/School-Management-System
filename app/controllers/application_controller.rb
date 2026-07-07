class ApplicationController < ActionController::Base
  include ActivityLogger
  helper_method :current_admin, :logged_in?
  before_action :check_session_timeout


  private

  def current_admin
    if session[:admin_id]
      @current_admin ||= Admin.find_by(id: session[:admin_id])
    elsif cookies.signed[:admin_id]
      admin = Admin.find_by(id: cookies.signed[:admin_id])

      if admin
        session[:admin_id] = admin.id
        session[:last_seen_at] = Time.current
        @current_admin = admin
      end
    end
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
