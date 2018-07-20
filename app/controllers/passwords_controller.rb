class PasswordsController < Devise::PasswordsController
  include ActionView::Helpers::TagHelper

  before_action :verify_user_reset, only: :edit

  def create
    @user = User.send_reset_password_instructions(request_params)
    if successfully_sent?(@user)
      render json: {
        "status": "success",
        "message": "Reset Password Link Sent to Email"
        }, status: :accepted
    else
      render json: {
        "status": "success",
        "message": "Incorrect Email."
        }, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.new
    set_minimum_password_length
    @user.reset_password_token = params[:reset_password_token]
  end

  def update
    @user = User.reset_password_by_token(new_password_params)

    if @user.errors.empty?
      if Devise.sign_in_after_reset_password
        sign_in(:user, @user)
      end
      render json: {
        "status": "success",
        }, status: :accepted
    else
      set_minimum_password_length
      render json: {
        "status": "error",
        "message": password_error_messages.to_s
        }, status: :unprocessable_entity
    end
  end

  private
  def request_params
    params.require(:user).permit(:email)
  end

  def new_password_params
    params.require(:user).permit(:reset_password_token, :password, :password_confirmation)
  end

  def verify_user_reset
    if !User.with_reset_password_token(params[:reset_password_token]).present?
      redirect_to root_path
    end
  end

  def password_error_messages 
    if @user
      return "" if @user.errors.empty?

      messages = @user.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    end
  end

  def after_resetting_password_path_for(resource)
    redirect_to root_path
  end
end
