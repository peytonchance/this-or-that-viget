class Api::PollsController < Api::ApiController
  before_action :verify_user_id
  
  def index
  end
  
  def create
   
  end
  
  def show
  end
  
  private
  def poll_params
    params.require(:poll).permit(:title, :option_a_img, :option_b_img, :option_a_url, :option_b_url, :option_a, :option_b, expire: [:days, :hours, :mins])
  end
  
  def verify_user_id
    if !User.find(params[:id]).present?
      render json: {
        "status": "error",
        "message": "No user ID provided."
        }, status: :unauthorized
    end
  end
end