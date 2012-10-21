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

  [:listeners, :lecturers].each do |people|
    has_and_belongs_to_many people,
      :join_table => people,
      :class_name => :Staff,
      :uniq => true,
      :select => [:id, :name, :nick, :avatar_file_name, :avatar_updated_at].map { |s| "\"staffs\".\"#{s}\"" },
      :after_add => "update_count_of_#{people}",
      :after_remove => "update_count_of_#{people}"
  end

  # deprecated, use listeners and lecturers instead
  # acts_as_voteable
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

  # scopes
  class << self

    def filter_by_tags(tags)
      without_states = []
      with_states = []

      tags.each do |word|
        case word
        when 'open'
          without_states << :closed
        when 'closed'
          with_states << :closed
        when 'zjg'
          with_states << :zjg
        when 'yq'
          with_states << :yq
        end
      end

      ret = scoped
      ret = ret.with_state(*with_states) if not with_states.empty?
      ret = ret.without_state(*without_states) if not without_states.empty?
      ret
    end

    def sort_by(tag)
      tag = tag.to_s.downcase
      case tag
      when 'voted'
        tally
      when 'updated'
        order('updated_at DESC')
      else
        scoped
      end.scoped
    end
  end

  private

  def update_count_of_listeners(listener)
    update_column :listener_count, listeners.count
  end

  def update_count_of_lecturers(lecturer)
    update_column :lecturer_count, lecturers.count
  end

end

