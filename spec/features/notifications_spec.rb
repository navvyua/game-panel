require 'rails_helper'

feature 'Notifications' do
  let(:user)     { create(:user) }
  let(:new_user) { build(:user) }

  scenario 'user successfully signs in' do
    sign_in user
    expect(page).to have_content(I18n.t('sessions.create.signed_in'))
  end

  scenario 'user fails sign in' do
    sign_in new_user
    expect(page).to have_content(I18n.t('sessions.create.incorrect_sign_in'))
  end
end
