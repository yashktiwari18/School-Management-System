class AdminsController < ApplicationController
  def new
    redirect_to login_path unless Admin.count.zero?

    @admin = Admin.new
  end

  def create
    redirect_to login_path unless Admin.count.zero?

    @admin = Admin.new(admin_params)

    if @admin.save
      redirect_to login_path,
                  notice: "Administrator created successfully. Please login."
    else
      render :new,
             status: :unprocessable_entity
    end
  end

  private

  def admin_params
    params.require(:admin).permit(
      :name,
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end
end
