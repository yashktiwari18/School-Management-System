class AddPaymentModeToFees < ActiveRecord::Migration[8.1]
  def change
    add_column :fees, :payment_mode, :string
  end
end
