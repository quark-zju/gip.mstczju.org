class AddUpdatedAtIndexToTopics < ActiveRecord::Migration
  def change
    change_table :topics do |t|
      t.index :updated_at
    end
  end
end
