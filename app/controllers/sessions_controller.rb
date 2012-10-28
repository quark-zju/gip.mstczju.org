class SessionsController < Devise::SessionsController

  # custom session controller to skip cancan authorization check
  skip_authorization_check

  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    if is_navigational_format?
      set_flash_message(:notice, :signed_in)
    end
    sign_in(resource_name, resource)
    respond_with resource, :location => root_path
  end

end
