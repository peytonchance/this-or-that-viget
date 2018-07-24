class Api::PollsController < Api::ApiController
  before_action :verify_user_id, only: :create
  before_action :verify_poll_id, only: :show
  
  def index
    render json: {
      poll: JSON.parse(Poll.recent.to_json)
      }, status: :accepted
  end
  
  def create
   
  end
  
  def show
    render json: {
      poll: JSON.parse(Poll.find(params[:id]).to_json)
      }, status: :accepted
  end
  
  private
  def poll_params
    params.require(:poll).permit(:title, :option_a_img, :option_b_img, :option_a_url, :option_b_url, :option_a, :option_b, expire: [:days, :hours, :mins])
  end
  
  def verify_user_id
    if !params[:user_id].present? || !User.find(params[:user_id]).present?
      render json: {
        "status": "error",
        "message": "No user ID provided."
        }, status: :unauthorized
    end
  end
  
  def verify_poll_id
    if !params[:id].present? || !Poll.find(params[:id]).present?
      render json: {
        "status": "error",
        "message": "No poll ID provided."
        }, status: :unauthorized
    end
  end
end