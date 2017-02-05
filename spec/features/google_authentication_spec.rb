require 'rails_helper'

feature 'Google authentication' do
  context 'with valid hash' do
    before(:each) do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: Faker::Number.number(8),
        info: { email: Faker::Internet.email, name: Faker::Name.first_name }
      )
    end

    scenario 'user signs in' do
      visit sign_in_path
      click_link I18n.t('sessions.new.sign_in_google')
      expect(page).to have_content(I18n.t('shared.header.sign_out'))
    end

    scenario 'user signs up' do
      visit sign_up_path
      click_link I18n.t('sessions.new.sign_in_google')
      expect(page).to have_content(I18n.t('shared.header.sign_out'))
    end

    scenario 'user signs out' do
      visit sign_in_path
      click_link I18n.t('sessions.new.sign_in_google')
      click_link I18n.t('shared.header.sign_out')
      expect(page).to_not have_content(I18n.t('shared.header.sign_out'))
    end
  end

  context 'with invalid hash' do
    before(:each) do
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    end

    scenario 'user signs in' do
      visit sign_in_path
      click_link I18n.t('sessions.new.sign_in_google')
      expect(page).to_not have_content(I18n.t('shared.header.sign_out'))
    end

    scenario 'user signs up' do
      visit sign_up_path
      click_link I18n.t('sessions.new.sign_in_google')
      expect(page).to_not have_content(I18n.t('shared.header.sign_out'))
    end
  end
end
