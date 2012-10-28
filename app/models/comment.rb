# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  title            :string(50)       default("")
#  comment          :text
#  commentable_id   :integer
#  commentable_type :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  attr_accessible :title, :comment, :user_id, :commentable_type, :commentable_id

  validates_presence_of :comment

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user, :class_name => 'Staff'

  after_create :send_notifications

  private

  def send_notifications
    # send notifications
    topic = commentable
    return unless topic.is_a?(Topic)

    # notify mentioned
    mentioner = Staff.find(user_id)
    notified = []
    comment.scan(/@([^, ]+)/).map(&:first).uniq.each do |name|
      staff = Staff.find_by_name(name) || Staff.find_by_nick(name)
      next if !staff || staff.id == user_id

      notified << staff.id
      staff.notifications.create!(:topic_id => topic.id, :message => "#{mentioner.name} mentioned you.")
    end

    # notify all observers
    topic.observers.includes(:notifications).each do |staff|
      next if staff.id == user_id || notified.include?(staff.id)
      staff.notifications.create!(:topic_id => topic.id, :message => "#{mentioner.name} added a new comment.")
    end

  end

end
