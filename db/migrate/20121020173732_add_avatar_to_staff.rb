class AddAvatarToStaff < ActiveRecord::Migration

  def self.up
    add_attachment :staffs, :avatar
  end

  def self.down
    remove_attachment :staffs, :avatar
  end

end
