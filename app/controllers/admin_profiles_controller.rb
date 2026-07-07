class AdminProfilesController < ApplicationController
  before_action :require_login

  def show
    @admin = current_admin
  end

  def edit
    @admin = current_admin
  end

  def update
    @admin = current_admin

    if @admin.update(admin_params)
      redirect_to admin_profile_path,
                  notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def admin_params
    params.require(:admin).permit(
      :name,
      :username
    )
  end
end
