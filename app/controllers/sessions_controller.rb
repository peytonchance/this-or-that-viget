class SessionsController < Devise::SessionsController
  def create
    @user = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in("user", @user)
    render json: {
      "status": "success"  
    }
  end
end
