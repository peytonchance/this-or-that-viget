class OptionAsController < ApplicationController
  def create
    @poll = Poll.find(params[:poll_id])
    @vote = @poll.votes.new(user: current_user, option: 0)
    if @vote.save
      binding.pry
      render json: {
        "status": "success",
        "poll": @poll.id,
        "optionA": @poll.fraction_of_votes(0),
        "optionB": @poll.fraction_of_votes(1)
        }, status: :accepted
    else
      render json: {
        "status": "error",
        "message": "Please try again"
        }, status: :unprocessable_entity
    end
  end

  def update
  end
end
