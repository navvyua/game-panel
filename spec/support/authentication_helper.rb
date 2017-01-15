module AuthenticationHelper
  def sign_in(user)
    visit sign_in_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end

  def sign_up(user)
    visit sign_up_path
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_button 'Sign Up'
  end
end
