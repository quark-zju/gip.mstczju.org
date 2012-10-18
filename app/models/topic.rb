# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  content     :text
#  staff_id    :integer
#  category_id :integer
#  state       :integer
#  text_filter :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Topic < ActiveRecord::Base
  belongs_to :staff

  validates_uniqueness_of :title
  validates_presence_of :title

  acts_as_voteable
  acts_as_commentable

  TEXT_FILTER_LIST = [:markdown, :textile]
  STATES = [:closed, :yq, :zjg]

  bitmask :state, :as => STATES

  attr_accessible :content, :title, :state, :text_filter, *STATES

  STATES.each do |st|
    define_method(st) { state.include? st }
    define_method("#{st}=") { |x| x && x.to_s != '0' ? (state << st) : state.delete(st) }
  end

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
