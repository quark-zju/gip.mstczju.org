class Preferences
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :editor, :vote_display

  EDITOR_OPTIONS = [:Normal, :ACE]
  VOTE_DISPLAY_OPTIONS = [:Number, :Zheng]

  def initialize(attributes = {})
    update_attributes attributes
  end

  def update_attributes(attributes = {})
    attributes.each do |key, value|
      case key.to_s
      when 'editor', 'vote_display'
        send("#{key}=", value.to_i)
      end
    end
  end

  def persisted?
    false
  end

end
