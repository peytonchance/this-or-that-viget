require 'rails_helper'

feature 'User signs up' do
  scenario 'with valid data', js:true do
    visit root_path
    click_link 'Sign up'
    within('.sign-up') do
      fill_in 'Username', with: 'username'
      fill_in 'Email', with: 'username@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'
    end

    #expect(page).to have_text 'Welcome! You have signed up successfully.'
    #expect(page).to have_link 'Sign Out'
    expect(page).to have_current_path root_path
    expect(page).to have_content 'username'
  end

  scenario 'with invalid data', js:true do
    visit root_path
    click_link 'Sign up'
    within('.sign-up') do
      click_button 'Sign up'
    end

    expect(page).to have_text "email can't be blank"
    expect(page).to have_text "password can't be blank"
    expect(page).to have_no_link 'Sign out'
  end
end
