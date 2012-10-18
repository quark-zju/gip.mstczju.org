# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  content     :text
#  staff_id    :integer
#  category_id :integer
#  status      :integer
#  text_filter :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Topic < ActiveRecord::Base
  belongs_to :staff
  attr_accessible :content, :title, :status, :text_filter

  validates_uniqueness_of :title
  validates_presence_of :title

  acts_as_voteable
  acts_as_commentable

  STATUS_LIST = [:open, :closed]
  TEXT_FILTER_LIST = [:markdown, :textile]

  def markup
    filename = case text_filter
               when 0
                 'topic.md'
               when 1
                 'topic.textile'
               end
    GitHub::Markup.render(filename, content)
  end
end
