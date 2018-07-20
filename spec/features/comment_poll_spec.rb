require 'rails_helper'

RSpec.describe "Commenting on a poll", type: :feature, js: true do
  context "with an existing poll" do
    let!(:poll) {create(:poll)}
    
    context "with no logged in user" do
      it 'does not allow commenting' do
        visit poll_path(poll)
        expect(page).to have_content "Log in to comment."
        find('#comment-submit').click
        expect(page).to have_content "You must login to comment."
      end
    end
    
    context "with a logged in user" do
      let!(:user) {create(:user)}
      
      before do
        login_as(user)
        visit poll_path(poll)
      end
      
      it "allows you to comment" do
        fill_in 'new-comment', with: "Demo comment"
        find('#comment-submit').click
        expect(page).to have_content 'Demo comment'
      end
      
      it "doesn't allow you to comment with blank body" do
        fill_in 'new-comment', with: ""
        find('#comment-submit').click
        expect(page).to have_content "Body can't be blank"
      end
    end
  end
end