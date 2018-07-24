class Api::RegistrationsController < Api::ApiController
  def create
    @user = User.new(registration_params)
    if @user.save
      render json: {
        "status": "success",
        "user": {
          "id": @user.id,
          "email": @user.email,
          "username": @user.username
          }
        }, status: :accepted
    else
      render json: {
        "status": "error",
        "messsage": @user.errors.full_messages
        }, status: :unprocessable_entity
    end
  end
  
  private
  def registration_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end