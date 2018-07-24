class Api::RegistrationsController < Api::ApiController
  def create
    @user = User.new(registration_params)
    if @user.save
      render json: {
        "status": "success",
        "user": "blah"
        }, status: :accepted
    else
      render json: 
    end
  end
  
  private
  def registration_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end