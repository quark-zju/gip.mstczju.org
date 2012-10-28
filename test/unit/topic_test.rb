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

require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
