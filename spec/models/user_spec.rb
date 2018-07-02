require 'rails_helper'

RSpec.describe User, type: :model do
  it "has none to begin with" do
    expect(User.count).to eq 0
  end

  context "has already one user created" do
    let!(:user) {create(:user)}
    
    it "has only one" do
      expect(User.count).to eq 1
    end

    it "doesn't add user with same username" do
      user = build(:user, email: 'another@example.com')
      user.save

      expect(user.save).to eq false
      expect(user.errors.full_messages.first).to eq "Username has already been taken"
    end

    it "doesn't add user with same email" do
      user = build(:user, username: 'johndoe')
      user.save

      expect(user.save).to eq false
      expect(user.errors.full_messages.first).to eq "Email has already been taken"
    end
  end
  
  it "doesn't allow emails that disobey the format" do
    user = build(:user, email: 'hello.com')
    user.save
    
    expect(user.save).to eq false
    expect(user.errors.full_messages.first).to eq "Email is invalid"
  end
end
