class Api::UsersController < Api::ApiController
  def show
    user = User.find(params[:id])
    if params[:filter]
      
      if params[:filter] == "mypolls"
        render json: {
        status: "success",
        poll: user.polls.order(created_at: :desc)
        }, status: :ok
        
      elsif params[:filter] == "following"
        render json: {
        status: "success",
        poll: user.followed_polls.order(created_at: :desc)
        }, status: :ok
        
      else
        render json: {
        status: "error",
        message: "Invalid arguments."
        }, status: :bad_request
      end
      
    else
      render json: {
        status: "success",
        user: user
        }, status: :ok
    end
  end
end