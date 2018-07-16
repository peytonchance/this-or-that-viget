module LoginHelper
  def login_user(user)
    visit root_path
    click_link 'Log in'
    within('.log-in') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end
  end
end