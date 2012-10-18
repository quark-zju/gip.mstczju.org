class ApplicationController < ActionController::Base
  before_filter :check_useragent

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

  private

  def check_useragent
    if request.user_agent[/MSIE [5-8]\./]
      flash[:alert] = 'Your browser is not supported. Please use a modern browser.'
    end
  end
end
