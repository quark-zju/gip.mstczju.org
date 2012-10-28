class AddUniqueIndexToTopicsStaffs < ActiveRecord::Migration
  def change
    [:listeners, :lecturers].each do |name|
      # duplicated = execute("select * from #{name} as T1 where (select count(*) from #{name} as T2 where T1.staff_id = T2.staff_id and T1.topic_id = T2.topic_id) > 1")
      # execute("delete from #{name} where (select count(*) from #{name} as T2 where staff_id = T2.staff_id and topic_id = T2.topic_id) > 1")

      # inserted = {}
      # duplicated.each do |row|
      #   next if inserted["#{staff_id},#{topic_id}"]
      #   staff_id = row['staff_id'] || row[0]
      #   topic_id = row['topic_id'] || row[1]
      #   Topic.find(topic_id).send(name).send(:push, Staff.find(staff_id))
      #   inserted["#{staff_id},#{topic_id}"] = true
      # end

      change_table name do |t|
        t.index [:topic_id, :staff_id], unique: true
      end
    end
  end
end
