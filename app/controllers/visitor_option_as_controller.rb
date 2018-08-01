class VisitorOptionAsController < ApplicationController
  include VisitorVoting
  
  def create
   create_vote_for(0, request.remote_ip)
  end

  def update
    update_vote_for(0, request.remote_ip)
  end
  
  def destroy
    destroy_vote_for(0, request.remote_ip)
  end
end
