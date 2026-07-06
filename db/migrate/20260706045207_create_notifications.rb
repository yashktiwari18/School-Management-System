class CreateNotifications < ActiveRecord::Migration[8.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :message
      t.string :notification_type
      t.boolean :is_read

      t.timestamps
    end
  end
end
