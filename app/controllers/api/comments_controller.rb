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
      respond_with_error(comment.errors.full_messages)
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