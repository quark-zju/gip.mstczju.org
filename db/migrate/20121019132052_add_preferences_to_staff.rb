class AddPreferencesToStaff < ActiveRecord::Migration
  def change
    change_table :staffs do |t|
      t.text :preferences
    end
  end
end
