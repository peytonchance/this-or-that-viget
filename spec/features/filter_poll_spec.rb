require 'rails_helper'

RSpec.describe "Clicking links on header to filter polls", type: :feature do
  context "with existing polls and users" do
    let! (:test_user) {create(:user)}
    let! (:test_poll) {create(:poll, user: test_user, title: "Example Poll", option_a: 'Choice 1', option_b: 'Choice 2')}
    let! (:follow_poll) {create(:poll, title: "Another example poll", option_a: 'Decision 1', option_b: 'Decision 2')}
    
    before do
      login_as(test_user)
    end
    
    it 'has all the polls on the Feed page' do
      visit root_path
      expect(page).to have_content 'Example Poll'
      expect(page).to have_content 'Another example poll'
    end
    
    it 'allows user to view their polls' do
      visit root_path
      click_on 'My Polls'
      expect(page).to have_content test_poll.title
      expect(page).to have_content test_poll.option_a
      expect(page).to have_content test_poll.option_b
      
      expect(page).to_not have_content follow_poll.title
      expect(page).to_not have_content follow_poll.option_a
      expect(page).to_not have_content follow_poll.option_b
    end
    
    it 'allows user to view followed polls', js:true do
      visit root_path
      find("#poll-follow-path-#{follow_poll.id}").click
      
      click_on 'Following'
      expect(page).to_not have_content test_poll.title
      expect(page).to_not have_content test_poll.option_a
      expect(page).to_not have_content test_poll.option_b
      
      expect(page).to have_content follow_poll.title
      expect(page).to have_content follow_poll.option_a
      expect(page).to have_content follow_poll.option_b
    end
    
  end
end