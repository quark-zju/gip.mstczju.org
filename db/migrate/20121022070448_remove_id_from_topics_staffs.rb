class RemoveIdFromTopicsStaffs < ActiveRecord::Migration
  def up
    remove_column :listeners, :id
    remove_column :lecturers, :id
  end

  def down
  end
end
