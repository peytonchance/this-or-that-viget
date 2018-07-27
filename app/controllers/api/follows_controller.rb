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
      render json: {
        status: "error",
        message: "Unexpected error"
      }, status: :bad_request
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
      render json: {
        status: "error",
        message: "Unexpected error"
      }, status: :bad_request
    end
  end
  
  def verify_user_id
    if !params[:user_id].present? || !User.find_by(id: params[:user_id]).present?
      render json: {
        status: "error",
        message: "Invalid User ID"
        }, status: :unauthorized
    else
      @user = User.find_by(id: params[:user_id])
    end
  end

  def verify_poll_id
    if !params[:poll_id].present? || !Poll.find_by(id: params[:poll_id]).present?
      render json: {
        status: "error",
        message: "Invalid Poll ID"
        }, status: :unauthorized
    else
      @poll = Poll.find_by(id: params[:poll_id])
    end
  end
end