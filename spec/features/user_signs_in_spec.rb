require 'rails_helper'

feature 'User signs in' do
  let!(:user) {create(:user)}
  
  scenario 'with valid credentials' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_text 'Signed in'
    expect(page).to have_link 'Sign out'
    expect(page).to have_current_path root_path
  end

  scenario 'with invalid credentials' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: "invalid"
    click_button 'Log in'

    expect(page).to have_text 'Invalid Email or password.'
    expect(page).to have_no_link 'Sign Out'
    expect(page).to_not have_current_path root_path
  end
end
