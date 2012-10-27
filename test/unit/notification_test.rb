# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  staff_id   :integer          not null
#  topic_id   :integer          not null
#  message    :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
