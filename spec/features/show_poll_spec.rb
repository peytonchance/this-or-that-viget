require 'rails_helper'

RSpec.describe "Showing a poll", type: :feature do
  context "With a valid poll created" do
    let!(:user) {create(:user)}
    let!(:poll) {create(:poll, user: user)}
    
    before do
      login_as(user)
      visit root_path
    end
    
    it 'goes to single poll view after clicking on poll title' do
      expect(page).to have_content poll.title
      click_on poll.title
      expect(page).to have_current_path poll_path(poll)
    end
    
    it 'has all the proper elements' do
      visit poll_path(poll)
      expect(page).to have_content "7 days left"
      expect(page).to have_content poll.title
      expect(page).to have_content poll.option_a
    end
  end
end