module AuthenticationHelper
  def sign_in(user)
    visit sign_in_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button I18n.t('sessions.new.sign_in')
  end

  def sign_up(user)
    visit sign_up_path
    fill_in 'Username', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_button I18n.t('users.new.sign_up')
  end
end
