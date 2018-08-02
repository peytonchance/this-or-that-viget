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
  
  describe "testing poll validations" do
    it "validates characters of title" do
      poll = build(:poll, title: "Poll")
      expect(poll.save).to eq false
      expect(poll.errors.full_messages.first).to eq "Title is too short (minimum is 10 characters)"
      
      poll = build(:poll, title: "This is a really really really long poll title")
      expect(poll.save).to eq false
      expect(poll.errors.full_messages.first).to eq "Title is too long (maximum is 30 characters)"
    end
  end
end