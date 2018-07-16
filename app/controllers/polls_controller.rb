class PollsController < ApplicationController
  def index
  end

  def create
    if both_option_img(poll_params.slice(:option_a_img, :option_b_img, :option_a_url, :option_b_url))
      render json: {
        "status": "error",
        "message": "Cannot have both a file attached and an image link. Please choose one option"
        }
    else
      @poll = current_user.polls.new(poll_params.slice(:title, :option_a, :option_b))
      @poll.expired = false
      @poll.expiry_time = generate_expire_time(poll_params.slice(:expire_days, :expire_hours, :expire_mins))
      render json: {
        "status": "success"
        }
    end
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

  def both_option_img(img_params)
    opt_a_img = !(img_params[:option_a_img].nil?)
    opt_b_img = !(img_params[:option_b_img].nil?)
    opt_a_url = !(img_params[:option_a_url].empty?)
    opt_b_url = !(img_params[:option_b_url].empty?)
    (opt_a_img and opt_a_url) or (opt_b_img and opt_b_url)
  end
end
