class FollowsController < ApplicationController
  def create
    binding.pry
    render json: {
      "status": "success"
      }, status: :accepted
  end

  def destroy
  end
end
