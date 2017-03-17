class UserMailer < ApplicationMailer
  def welcome_email(user, password)
    @user = user
    @user_password = password
    mail(to: @user.email, subject: I18n.t('email.welcome.subject'))
  end

  def character_validating_email(user, character)
    @user = user
    @character = character
    mail(to: @user.email, subject: I18n.t('email.character_validating.subject'))
  end
end
