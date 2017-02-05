require 'rails_helper'

feature 'Facebook authentication' do
  context 'with valid hash' do
    before(:each) do
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: 'facebook',
        uid: Faker::Number.number(8),
        info: { email: Faker::Internet.email, name: Faker::Name.first_name }
      )
    end

    scenario 'user signs in' do
      visit sign_in_path
      click_link I18n.t('sessions.new.sign_in_facebook')
      expect(page).to have_content(I18n.t('shared.header.sign_out'))
    end

    scenario 'user signs up' do
      visit sign_up_path
      click_link I18n.t('sessions.new.sign_in_facebook')
      expect(page).to have_content(I18n.t('shared.header.sign_out'))
    end

    scenario 'user signs out' do
      visit sign_in_path
      click_link I18n.t('sessions.new.sign_in_facebook')
      click_link I18n.t('shared.header.sign_out')
      expect(page).to_not have_content(I18n.t('header.sign_out'))
    end
  end

  context 'with invalid hash' do
    before(:each) do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    end

    scenario 'user signs in' do
      visit sign_in_path
      click_link I18n.t('sessions.new.sign_in_facebook')
      expect(page).to_not have_content(I18n.t('shared.header.sign_out'))
    end

    scenario 'user signs up' do
      visit sign_up_path
      click_link I18n.t('sessions.new.sign_in_facebook')
      expect(page).to_not have_content(I18n.t('shared.header.sign_out'))
    end
  end
end
