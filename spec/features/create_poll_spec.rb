require 'rails_helper'

RSpec.describe "Creating a poll", type: :feature do
  let!(:user) {create(:user)}
  
  #temporary before block until this branch is merged in with current changes
  before do
    visit new_user_session_path
    within(".new_user") do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_on 'Log in'
    end
  end

  describe "entering form information", js:true do 
    it "properly creates a form" do
      #inputting form fields
      click_on "Create a Poll"
      fill_in 'poll-title', with: 'Demo Poll with Options'
      fill_in 'poll_option_a_url', with: 'https://www.gstatic.com/webp/gallery3/1.sm.png'
      fill_in 'poll_option_b_url', with: 'https://www.gstatic.com/webp/gallery3/1.sm.png'
      fill_in 'poll-option-a', with: 'Pizza'
      fill_in 'poll-option-b', with: 'Taco'
      fill_in 'poll_expire_days', with: '1'
      fill_in 'poll_expire_hours', with: '0'
      fill_in 'poll_expire_mins', with: '0'
      click_on 'Submit poll'
      
      #testing if poll is in DB. Viewing poll on index page will come in another PR. When done, I will refactor this test to check if new poll appears on page. 
      binding.pry
    end
  end
end