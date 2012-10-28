class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.references :staff
      t.references :category
      t.integer :status
      t.integer :text_filter

      t.timestamps
    end
    add_index :topics, :staff_id
    add_index :topics, :category_id
    add_index :topics, :title
  end
end
