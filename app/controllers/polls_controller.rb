class PollsController < ApplicationController
  include ActionView::Helpers::TagHelper
  def index
    @polls = Poll.all
  end

  def create
    #basic information
    @poll = current_user.polls.new(poll_params.except(:expire_days, :expire_hours, :expire_mins))

    #expiry time
    @poll.expired = false
    @poll.expiry_time = generate_expire_time(poll_params.slice(:expire_days, :expire_hours, :expire_mins))

    if @poll.save 
      render json: {
        "status": "success"
        }
    else
      render json: {
        "status": "error",
        "message": poll_error_messages.to_s
        }, status: :unprocessable_entity
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
    DateTime.now.utc
  end

  def both_option_img(img_params)
    opt_a_img = !(img_params[:option_a_img].nil?)
    opt_b_img = !(img_params[:option_b_img].nil?)
    opt_a_url = !(img_params[:option_a_url].empty?)
    opt_b_url = !(img_params[:option_b_url].empty?)
    (opt_a_img and opt_a_url) or (opt_b_img and opt_b_url)
  end

  def poll_error_messages
    if @poll
      return "" if @poll.errors.empty?

      messages = @poll.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    end
  end
end
