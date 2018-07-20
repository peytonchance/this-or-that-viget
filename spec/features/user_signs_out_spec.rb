require 'rails_helper'

feature 'User signs out', js:true do
  let!(:user) {create(:user)}
  scenario 'user signed in' do

    sign_in user

    visit root_path

    click_link user.username
    click_link "log out"

    expect(page).to have_link 'Log in'
    expect(page).to have_link 'Sign up'
    expect(page).to_not have_content user.username
    expect(page).to have_current_path root_path
  end
end
