class RegistrationController < Devise::RegistrationsController
  include ActionView::Helpers::TagHelper

  def create
    session[:return_to] ||= request.referer
    @user = User.new(sign_up_params)
    @user.save
    if @user.persisted?
      set_flash_message! :notice, :signed_up
      sign_up("user", @user)
      render json: {
        "status": "success",
        }
    else
      clean_up_passwords @user
      set_minimum_password_length
      render json: {
        "status": "error",
        "message": error_messages.to_s
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
