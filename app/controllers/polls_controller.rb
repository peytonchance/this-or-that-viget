class PollsController < ApplicationController
  def index
  end
  
  def create
    @poll = current_user.polls.new(poll_params.slice(:title, :option_a, :option_b))
    @poll.expired = false
    @poll.expiry_time = generate_expire_time(poll_params.slice(:expire_days, :expire_hours, :expire_mins))
    binding.pry
    render json: {
      "status": "success"
      }
  end
  
  
  private
  def poll_params
    params.require(:poll).permit(:title, :option_a_img, :option_b_img, :option_a_url, :option_b_url, :option_a, :option_b, :expire_days, :expire_hours, :expire_mins)
  end
  
  def generate_expire_time(expire_params)
    days = expire_params[:expire_days].to_i
    hours = expire_params[:expire_hours].to_i
    mins = expire_params[:expire_mins].to_i
    @expire_time = current_datetime + days.day + hours.hour + mins.minutes
  end
  
  def current_datetime
    DateTime.now.change(offset: "+0000")
  end
end
