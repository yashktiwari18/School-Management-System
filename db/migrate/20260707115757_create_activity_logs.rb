class CreateActivityLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :activity_logs do |t|
      t.references :admin, null: false, foreign_key: true
      t.string :action
      t.string :module_name
      t.text :description

      t.timestamps
    end
  end
end
