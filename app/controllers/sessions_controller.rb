class SessionsController < ApplicationController

  before_action :redirect_if_logged_in, only: [:new]

  def new
  end

  def create
    admin = Admin.find_by(username: params[:username])

    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to dashboard_path, notice: "Login Successful!"
    else
      flash.now[:alert] = "Invalid Username or Password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to login_path, notice: "Logged out successfully."
  end

  private

  def redirect_if_logged_in
    redirect_to dashboard_path if logged_in?
  end

end