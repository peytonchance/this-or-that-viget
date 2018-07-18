class FollowsController < ApplicationController
  def create
    if user_signed_in?
      @poll = Poll.find(params[:poll_id])
      @follow = @poll.follows.new(user: current_user)
      if @follow.save
        render json: {
          "status": "success",
          "content": "unfollow",
          "pollId": @poll.id,
          "path": poll_follow_path(@poll.id, @follow.id),
          "method": "delete"
          }, status: :accepted
      else
        render json: {
          "status": "error",
          "content": "reload and try again",
          }, status: :unprocessable_entity
      end
    else
      render json: {
        "status": "error",
        "content": "log in to vote"
        }, status: :precondition_failed 
    end
  end

  def destroy
    @poll = Poll.find(params[:poll_id])
    @follow = @poll.follows.find(params[:id])
    if @follow.destroy
      render json: {
          "status": "success",
          "content": "follow",
          "pollId": @poll.id,
          "path": poll_follows_path(@poll),
          "method": "post"
          }, status: :accepted
    else
      render json: {
          "status": "error",
          "content": "reload and try again",
          }, status: :unprocessable_entity
    end
  end
end
