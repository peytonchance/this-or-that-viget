class RegistrationController < Devise::RegistrationsController
  include ActionView::Helpers::TagHelper
  
  def create
    @user = User.new(sign_up_params)

    @user.save
    if @user.persisted?
      if @user.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up("user", @user)
        respond_with @user, location: after_sign_up_path_for(@user)
      else
        set_flash_message! :notice, :"signed_up_but_#{@user.inactive_message}"
        expire_data_after_sign_in!
        respond_with @user, location: after_inactive_sign_up_path_for(@user)
      end
    else
      clean_up_passwords @user
      set_minimum_password_length
      #binding.pry
      render json: {
        "status": "success"
        }
    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
  end

  def error_messages 
    if @user
      return "" if @user.errors.empty?

      messages = @user.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    end
  end
end
