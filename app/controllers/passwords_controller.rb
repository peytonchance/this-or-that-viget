class PasswordsController < Devise::PasswordsController
  before_action :verify_user_reset?, only: :edit
  
  def create
    @user = User.send_reset_password_instructions(password_params)

    if successfully_sent?(@user)
      binding.pry
      render json: {
        "status": "success",
        "message": "Reset Password Link Sent to Email"
        }, status: :accepted
    else
      render json: {
        "status": "success",
        "message": "Error. Please Try Again"
        }, status: :unprocessable_entity
    end
  end
  
  def edit
    @user = User.new
    set_minimum_password_length
    @user.reset_password_token = params[:reset_password_token]
  end
  
  private
  def password_params
    params.require(:user).permit(:email)
  end
  
  def verify_user_reset?
    User.with_reset_password_token(params[:reset_password_token]).present?
  end
  
  def after_resetting_password_path_for(resource)
      redirect_to root_path
    end
end
