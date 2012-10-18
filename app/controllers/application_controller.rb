class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization

  def current_ability
    @current_ability ||= Ability.new(current_staff)
  end

  rescue_from CanCan::AccessDenied do |ex|
    if current_staff
      render text: ex.message
    else
      redirect_to new_staff_session_path
    end
  end
end
