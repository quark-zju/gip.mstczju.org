class StaffsController < ApplicationController

  skip_authorization_check :preferences

  def preferences
    if request.post?
      # save
      if current_staff.update_attribute :preferences, Preferences.new(params[:preferences])
        flash[:notice] = 'Preferences saved.'
      else
        flash[:notice] = 'Failed to save preferences.'
      end
    end

    @preferences = current_staff.preferences
  end

end
