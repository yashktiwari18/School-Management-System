class CreateFees < ActiveRecord::Migration[8.1]
  def change
    create_table :fees do |t|
      t.references :student, null: false, foreign_key: true
      t.decimal :total_fee
      t.decimal :paid_fee
      t.decimal :due_fee
      t.date :payment_date
      t.string :status

      t.timestamps
    end
  end
end
