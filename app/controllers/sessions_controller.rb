class SessionsController < ApplicationController
  skip_before_action :check_session_timeout, only: [ :destroy ]
  before_action :redirect_if_logged_in, only: [ :new ]
    def new
    end

  def create
    admin = Admin.find_by(username: params[:username])

    session[:admin_id] = admin.id
    session[:last_seen_at] = Time.current

    if params[:remember_me] == "1"
      cookies.permanent.signed[:admin_id] = admin.id
    else
      cookies.delete(:admin_id)
    end

    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to dashboard_path, notice: "Login Successful!"
    else
      flash.now[:alert] = "Invalid Username or Password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  reset_session
  cookies.delete(:admin_id)

  redirect_to login_path,
              notice: "Logged out successfully."
  end


  private

  def redirect_if_logged_in
    redirect_to dashboard_path if logged_in?
  end
end
