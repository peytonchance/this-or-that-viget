require 'rails_helper'

RSpec.describe Follow, type: :model do
  context "with a Poll and User already created" do
    let!(:user) {create(:user)}
    let!(:poll) {create(:poll, user: user)}
    
    it "poll & user currently follows no posts" do
      expect(user.follows.count).to eq(0)
      expect(poll.follows.count).to eq(0)
    end
    
    #let!(:follow) {}
    
    it "the poll has followers and the user is following a poll" do
      create(:follow, user: user, poll: poll)
      expect(user.followed_polls).to include(poll)
      expect(poll.follows.count).to eq(1)
    end
  end
end