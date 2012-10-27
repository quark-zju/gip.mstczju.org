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

class Notification < ActiveRecord::Base
  belongs_to :staff
  belongs_to :topic

  attr_accessible :message, :staff_id, :topic_id
end
