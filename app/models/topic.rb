# == Schema Information
#
# Table name: topics
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  content         :text
#  staff_id        :integer
#  category_id     :integer
#  state           :integer
#  text_filter     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  lecturer_count  :integer          default(0), not null
#  listener_count  :integer          default(0), not null
#  content_preview :text
#

class Topic < ActiveRecord::Base
  belongs_to :staff

  validates_uniqueness_of :title
  validates_presence_of :title

  has_many :notifications

  [:listeners, :lecturers, :observers].each do |people|
    q = ActiveRecord::Base.connection.method(:quote_column_name)

    options = {
      :join_table => people,
      :class_name => :Staff,
      :uniq => true,
      :select => [:id, :name, :email, :nick, :avatar_file_name, :avatar_updated_at].map { |s| "#{q['staffs']}.#{q[s]}" },
    }

    # update cached count, and add order
    if [:listeners, :lecturers].include?(people)
      define_method "update_count_of_#{people}" do |*_|
        update_column "#{people.to_s.sub(/s$/, '')}_count".to_sym, send(people).count
      end
      options.merge!(
        :after_add => "update_count_of_#{people}".to_sym,
        :after_remove => "update_count_of_#{people}".to_sym,
        :order => "#{q['relation_created_at']} ASC",
      )
    end

    has_and_belongs_to_many people, options
  end

  acts_as_commentable

  TEXT_FILTER_LIST = [:markdown, :textile]
  STATES = [:closed, :yq, :zjg]

  bitmask :state, :as => STATES

  attr_accessible :content, :title, :state, :text_filter, *STATES

  before_save :clean_content_preview

  STATES.each do |st|
    define_method(st) { state.include? st }
    define_method("#{st}=") { |x| x && x.to_s != '0' ? (state << st) : state.delete(st) }
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
      when 'voted', 'listeners'
        order('listener_count DESC')
      when 'lecturers'
        order('lecturer_count DESC')
      when 'updated'
        order('updated_at DESC')
      else
        self
      end.scoped
    end
  end

  private

  # def update_count_of_listeners(listener)
  #   update_column :listener_count, listeners.count
  # end

  # def update_count_of_lecturers(lecturer)
  #   update_column :lecturer_count, lecturers.count
  # end

  # def update_count_of_lecturers(lecturer)
  #   update_column :lecturer_count, lecturers.count
  # end

  def clean_content_preview
    update_column :content_preview, '' if persisted?
  end

end

