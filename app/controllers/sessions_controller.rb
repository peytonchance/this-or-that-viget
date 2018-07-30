class SessionsController < Devise::SessionsController
  def create
    @user = warden.authenticate!(auth_options)
    cookies.signed.permanent[:user_id] = @user.id
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in("user", @user)
    render json: {
      "status": "success"  
    }
  end
  
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    cookies.delete :user_id
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end
end
