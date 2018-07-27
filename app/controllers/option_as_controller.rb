class OptionAsController < ApplicationController
  include Voting
  
  def create
   create_vote_for(0)
  end

  def update
    update_vote_for(0)
  end
end
