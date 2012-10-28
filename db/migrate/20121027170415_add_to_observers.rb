class AddToObservers < ActiveRecord::Migration
  def up
    Topic.all.each do |topic|
      topic.observers << (topic.listeners + topic.lecturers + [topic.staff] + Staff.find(topic.comments.pluck(:user_id).uniq) - topic.observers).uniq
    end
  end

  def down
  end
end
