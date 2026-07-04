class ApplicationController < ActionController::Base
  helper_method :current_admin, :logged_in?

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
end
