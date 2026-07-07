class AddEmailAndPhoneToAdmins < ActiveRecord::Migration[8.1]
  def change
    add_column :admins, :email, :string
    add_column :admins, :phone, :string
  end
end
