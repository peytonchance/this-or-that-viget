class Api::PollsController < Api::ApiController
  before_action :verify_user_id, only: :create
  before_action :verify_poll_id, only: :show

  def index
    render json: {
      status: "success",
      poll: Poll.recent
      }, status: :accepted
  end

  def create
    user = User.find(params[:user_id])
    poll = user.polls.new(poll_params.merge(expired: false))
    if poll.save 
      render json: {
        status: "success",
        poll: poll
        }, status: :accepted
    else
      render json: {
        status: "error",
        message: poll.errors.full_messages
        }, status: :unprocessable_entity
    end
  end

  def show
    render json: {
      status: "success",
      poll: Poll.find(params[:id])
      }, status: :accepted
  end

  private
  def poll_params
    params.require(:poll).permit(
      :title, 
      :option_a_url, 
      :option_b_url, 
      :option_a, 
      :option_b, 
      expire: [
        :days, 
        :hours, 
        :mins
        ]
      )
  end

  def verify_user_id
    if !params[:user_id].present? || !User.find_by(id: params[:user_id]).present?
      render json: {
        status: "error",
        message: "Invalid User ID"
        }, status: :unauthorized
    end
  end

  def verify_poll_id
    if !params[:id].present? || !Poll.find_by(id: params[:id]).present?
      render json: {
        status: "error",
        message: "Invalid Poll ID"
        }, status: :unauthorized
    end
  end
end