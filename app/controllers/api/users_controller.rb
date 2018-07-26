class Api::UsersController < Api::ApiController
  def show
    @user = User.find_by(id: params[:id])
    if @user
      render json: {
        status: "success",
        user: @user
        }, status: :accepted
    else
      render json: {
        status: "error",
        message: "Invalid User ID"
        }, status: :bad_request
    end
  end
end