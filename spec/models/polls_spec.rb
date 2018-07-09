require 'rails_helper'

RSpec.describe Poll, type: :model do
  it "has none to begin with" do
    expect(Poll.count).to eq(0)
  end

  describe "#parent_is? poll instance method" do
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

  describe "expiry time poll instance methods" do
    context "with a poll created" do 
      let!(:poll) {create(:poll)}

      it "correctly gives the time left" do
        expect(poll.time_left).to eq("7 days")
      end

      it "returns false for it being expired" do
        expect(poll.expired?).to be false
      end

      it "returns true for it being expired" do
        poll.expired = true
        expect(poll.expired?).to be true
      end
    end
  end
end