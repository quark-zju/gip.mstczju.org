class ApplicationController < ActionController::Base
  before_filter :check_useragent
  before_filter :clean_cookies

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

  def clean_cookies
    # keep only session id cookie
    keep = [Rails.application.config.session_options[:key] || '_session_id']
    paths = request.path.split('/')[1...-1]
    paths = paths.inject(['/']) {|s,i| s << "#{s.last}#{i}/"}

    # try to delete other cookies
    # to save expensive cernet incoming bandwidth
    cookies.each do |key, value|
      if not keep.include?(key)
        # Remove this cookie.
        # Try all possible paths (Firefox requires path to be correct)
        # I haven't found high level to specify same key with different paths.
        # Use low level Rack api here.
        paths.each do |path|
          Rack::Utils.set_cookie_header! response.header, key, {
            value: '',
            expires: Time.at(0),
            path: path
          }
        end
      end
    end
  end

  def check_useragent
    if request.user_agent[/MSIE [5-8]\./]
      flash[:alert] = 'Your browser is not supported. Please use a modern browser.'
    end
  end
end
