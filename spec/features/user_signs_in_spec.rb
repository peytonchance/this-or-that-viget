require 'rails_helper'

feature 'User signs in' do
  let!(:user) {create(:user)}
  
  scenario 'with valid credentials', js:true, skip: true do
    visit root_path
    click_link 'Log in'
    within('.log-in') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    expect(page).to have_text user.username
    expect(page).to have_current_path root_path
  end

  scenario 'with invalid credentials', js:true, skip: true do
    visit root_path
    click_link 'Log in'
    within('.log-in') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'invalid'
      click_button 'Log in'
      expect(page).to have_text 'invalid email or password.'
    end

    expect(page).to_not have_content user.username
  end
end
