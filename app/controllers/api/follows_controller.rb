class Api::FollowsController < Api::ApiController
  before_action :verify_user_id
  before_action :verify_poll_id
  
  def create
    follow = @poll.follows.new(user: @user)
    if follow.save
      render json: {
        status: "success",
        follow: true
      }, status: :ok
    else
      respond_with_error("Unexpected error", status: :bad_request)
    end
  end
  
  def show
    render json: {
      status: "success",
      follow: @user.is_following?(@poll.id)
    }, status: :ok
  end
  
  def destroy
    follow = @poll.follows.find_by(user: @user)
    if follow&.destroy
      render json: {
        status: "success",
        follow: false
      }, status: :ok
    else
      respond_with_error("Unexpected error", status: :bad_request)
    end
  end
end