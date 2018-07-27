class OptionBsController < ApplicationController
  include Voting
  
  def create
   create_vote_for(1)
  end

  def update
    update_vote_for(1)
  end
end
