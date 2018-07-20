class PasswordsController < Devise::PasswordsController
  def create
    @user = User.send_reset_password_instructions(password_params)

    if successfully_sent?(@user)
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
    binding.pry
    @user = User.new
    set_minimum_password_length
    @user.reset_password_token = params[:reset_password_token]
  end
  
  private
  def password_params
    params.require(:user).permit(:email)
  end
end
