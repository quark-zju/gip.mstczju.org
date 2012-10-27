class StaffsController < ApplicationController

  skip_authorization_check [:preferences, :profile]
  before_filter :requires_login

  def preferences
    if request.post?
      # save
      if current_staff.update_attribute :preferences, Preferences.new(params[:preferences])
        flash.now[:notice] = 'Preferences saved.'
      else
        flash.now[:notice] = 'Failed to save preferences.'
      end
    end

    @preferences = current_staff.preferences
  end

  def profile
    @staff = current_staff

    if not request.get?
      if @staff.update_attributes(params[:staff])
        flash.now[:notice] = 'Profile updated.'
      else
        flash.now[:notice] = 'Failed to update profile.'
      end
    end
  end

  def notifications
    @topics = Topic.find(current_staff.notifications.pluck(:topic_id))
    @notifications = current_staff.notifications.order('id DESC').scoped
  end

end
