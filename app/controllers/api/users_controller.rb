class Api::UsersController < Api::ApiController
  def show
    user = User.find(params[:id])
    render json: {
      status: "success",
      user: user
      }, status: :ok
  end
end