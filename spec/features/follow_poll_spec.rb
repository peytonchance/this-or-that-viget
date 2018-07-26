require 'rails_helper'

RSpec.describe "Following a poll", type: :feature, js: true do
  context "with an existing poll" do
    let!(:poll) {create(:poll)}

    context "with no logged in user" do
      it 'does not allow visitor to follow' do
        visit poll_path(poll)
        expect(page).to have_content "follow"        
        find("#poll-follow-path-#{poll.id}").click
        expect(page).to have_content "log in to follow"
        
      end
    end

    context "with a logged in user" do
      let!(:user) {create(:user)}
      before do
        login_as(user)
      end

      it "allows user to vote on index page" do
        visit root_path
        expect(page).to have_content "follow"
        
        find("#poll-follow-path-#{poll.id}").click
        expect(page).to have_content "following"
      end

      it "allows user to vote on single poll page" do
        visit poll_path(poll)
        expect(page).to have_content "follow"
        
        find("#poll-follow-path-#{poll.id}").click
        expect(page).to have_content "following"
      end

      it "allows user to unfollow a poll" do
        visit poll_path(poll)
        expect(page).to have_content "follow"
        
        find("#poll-follow-path-#{poll.id}").click
        expect(page).to have_content "following"
        
        find("#poll-follow-path-#{poll.id}").click
        expect(page).to have_content "follow"
      end
    end
  end
end