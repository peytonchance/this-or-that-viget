require 'rails_helper'

RSpec.describe "Deleting a poll", type: :feature do
  context "with an existing poll and user" do
    let!(:user) {create(:user)}
    let!(:poll) {create(:poll, user: user)}

    it 'does not let user delete poll without being signed in' do
      visit root_path
      expect(page).to have_content poll.title
      expect(page).to_not have_content 'delete'
      expect(Poll.count).to eq(1)
    end

    it 'lets user delete poll when signed in' do
      login_as(user)
      visit root_path
      expect(page).to have_content poll.title
      expect(page).to have_content 'delete'
      click_on 'delete'
      
      expect(page).to_not have_content poll.title
      expect(page).to_not have_content 'delete'
      expect(Poll.count).to eq(0)
    end
    
    it 'does not let a user delete another users poll' do
      login_as(create(:user, username: 'anotheruser'))
      visit root_path
      expect(page).to have_content poll.title
      expect(page).to_not have_content 'delete'
      expect(Poll.count).to eq(1)
    end
  end
end