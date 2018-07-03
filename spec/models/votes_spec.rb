require 'rails_helper'

RSpec.describe Vote, type: :model do
  context 'with a Poll and User already created' do
    let!(:user) {create(:user)}
    let!(:poll) {create(:poll, user: user)}

    it "poll does not have any votes" do
      expect(poll.votes.count).to eq(0)
      expect(user.votes.count).to eq(0)
    end

    it "poll has votes from user" do
      create(:vote, poll: poll, user: user)
      expect(poll.votes.count).to eq(1)
      expect(user.voted_polls).to include(poll)
    end

    it "determines the correct percentage of two choices" do
      #populating the votes
      (-2..2).each do |n|
        vote_user = create(:user, username: "demouser#{n}", email: "demo#{n}@example.com")
        if n >= 0
           create(:vote, poll: poll, user: vote_user, option: 1)
        else
          create(:vote, poll: poll, user: vote_user)
        end
      end
      
      expect(poll.total_votes(0)).to eq(2)
      expect(poll.total_votes(1)).to eq(3)
      expect(poll.fraction_of_votes(1)).to eq(0.6)
      expect(poll.fraction_of_votes(0)).to eq(0.4)
    end
  end
end