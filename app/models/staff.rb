# == Schema Information
#
# Table name: staffs
#
#  id                  :integer          not null, primary key
#  email               :string(255)      default(""), not null
#  nick                :string(255)      default(""), not null
#  name                :string(255)      default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0)
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :string(255)
#  last_sign_in_ip     :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'net/http'
require 'json'

class Staff < ActiveRecord::Base
  devise :rememberable, :remote_authenticatable, :trackable

  attr_accessible :email, :remember_me, :nick, :password, :name, :preferences

  serialize :preferences, Preferences

  attr_accessor :password

  acts_as_voter

  def to_s
    name.presence || nick.presence || email.gsub(/@.*$/, '')
  end

  # used by devise_mstc
  def self.email_postfix
    '@mstczju.org'
  end

  def self.remote_authenticate_url
    'http://login.mstczju.org/plain'
  end
end
