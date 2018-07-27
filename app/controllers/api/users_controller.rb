class Api::UsersController < Api::ApiController
  def show
    binding.pry
    user = User.find(params[:id])
    render json: {
      status: "success",
      user: user
      }, status: :ok
  end
end