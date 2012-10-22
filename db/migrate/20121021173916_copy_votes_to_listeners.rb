class CopyVotesToListeners < ActiveRecord::Migration

  def up
    return unless defined?(ThumbsUp)
    # Vote.find(:all, :select => [:voteable_id, :voter_id]).each do |vote|
    #   topic_id = vote.voteable_id
    #   staff_id = vote.voter_id
    #   Topic.find(topic_id).listeners << Staff.find(staff_id)
    # end
  end

  def down
  end

end
