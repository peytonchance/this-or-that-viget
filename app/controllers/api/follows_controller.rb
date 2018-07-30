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
    if follow && follow.destroy
      render json: {
        status: "success",
        follow: false
      }, status: :ok
    else
      respond_with_error("Unexpected error", status: :bad_request)
    end
  end
  
  def verify_user_id
    @user = User.find_by(id: params[:user_id]) if params[:user_id].present?
    if @user.nil?
      respond_with_error("Invalid User ID")
    end
  end

  def verify_poll_id
    @poll = Poll.find_by(id: params[:poll_id]) if params[:poll_id].present?
    if @poll.nil?
      respond_with_error("Invalid Poll ID")
    end
  end

  def respond_with_error(message, status: :unprocessable_entity)
    render(json: {status: "error", message: message}, status: status)
  end
end