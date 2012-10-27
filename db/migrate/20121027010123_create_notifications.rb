class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :staff, :null => false
      t.references :topic, :null => false
      t.string :message, :null => false

      t.timestamps
    end
    add_index :notifications, :staff_id
    add_index :notifications, :topic_id
  end
end
