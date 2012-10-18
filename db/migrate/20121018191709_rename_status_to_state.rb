class RenameStatusToState < ActiveRecord::Migration
  def change
    rename_column :topics, :status, :state
  end
end
