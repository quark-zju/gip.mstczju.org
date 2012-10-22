class AddUniqueIndexToTopicsStaffs < ActiveRecord::Migration
  def change
    [:listeners, :lecturers].each do |name|
      execute "delete from #{name} where (select count(*) from #{name} as T2 where staff_id = T2.staff_id and topic_id = T2.topic_id) > 1"

      change_table name do |t|
        t.index [:topic_id, :staff_id], unique: true
      end
    end
  end
end
