class Api::SessionsController < Api::ApiController
  def create
    @user = User.find_by(email: session_params[:email])
    if @user && @user.valid_password?(session_params[:password])
      render json: {
        "status": "success",
        "user": @user
        }, status: :accepted
    else
      render json: {
        "status": "error",
        "message": "Invalid email or password."
        }, status: :bad_request
    end
  end
  
  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end