class PollsController < ApplicationController
  include ActionView::Helpers::TagHelper
  def index
    if params[:filter]
      if params[:filter] == "mypolls"
        @polls = current_user.polls
      else
        @polls = current_user.followed_polls
      end
    elsif params[:feed] && params[:feed] == "popular"
      @polls = Poll.popular
    else
      @polls = Poll.recent
    end
  end

  def create
    #basic information
    @poll = current_user.polls.new(poll_params.merge(expired: false))
    
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
  
  def show
    @poll = Poll.find(params[:id])
  end

  def destroy 
    session[:return_to] ||= request.referer
    poll = current_user&.polls&.find(params[:id])
    poll&.destroy
    
    redirect_to session.delete(:return_to)
  end

  private
  def poll_params
    params.require(:poll).permit(:title, :option_a_img, :option_b_img, :option_a_url, :option_b_url, :option_a, :option_b, expire: [:days, :hours, :mins])
  end

  def poll_error_messages
    if @poll
      return "" if @poll.errors.empty?

      messages = @poll.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    end
  end
end
