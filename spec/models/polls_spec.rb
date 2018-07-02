require 'rails_helper'

RSpec.describe Poll, type: :model do
  it "has none to begin with" do
    expect(Poll.count).to eq(0)
  end

  context "with a poll created" do 
    let!(:user) {create(:user)}
    let!(:poll) {create(:poll, user: user)}
    
    it "validates the parent user" do
      expect(poll.parent_is?(user)).to be true
    end
    
    let!(:other_user) {create(:user, username: 'otheruser', email: 'other@example.com')}
    
    it "returns false for a nonparent" do
      expect(poll.parent_is?(other_user)).to be false
    end
  end
end