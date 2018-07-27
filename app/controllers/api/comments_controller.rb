class Api::CommentsController < Api::ApiController
  before_action :verify_user_id, only: :create
  before_action :verify_poll_id

  def create
    comment = @poll.comments.new(comment_params.merge(user: @user))
    if comment.save 
      render json: {
        status: "success",
        comment: comment
        }, status: :ok
    else
      render json: {
        status: "error",
        message: comment.errors.full_messages
        }, status: :unprocessable_entity
    end
  end

  def show
    if params[:filter] == "count" 
      render json: {
        status: "success",
        comment: @poll.comments.count
      }, status: :ok
    else
      render json: {
        status: "success",
        comment: @poll.comments
      }, status: :ok
    end
  end
  
  def comment_params
    params.require(:comment).permit(:body)
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