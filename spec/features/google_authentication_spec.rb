require 'rails_helper'

feature 'Google authentication' do
  context 'with valid hash' do
    before(:each) do
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: Faker::Number.number(8),
        info: { email: Faker::Internet.email }
      )
    end

    scenario 'user signs in' do
      visit sign_in_path
      click_link 'Google'
      expect(page).to have_content('Sign Out')
    end

    scenario 'user signs up' do
      visit sign_up_path
      click_link 'Google'
      expect(page).to have_content('Sign Out')
    end

    scenario 'user signs out' do
      visit sign_in_path
      click_link 'Google'
      click_link 'Sign Out'
      expect(page).to_not have_content('Sign Out')
    end
  end

  context 'with invalid hash' do
    before(:each) do
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    end

    scenario 'user signs in' do
      visit sign_in_path
      click_link 'Google'
      expect(page).to_not have_content('Sign Out')
    end

    scenario 'user signs up' do
      visit sign_up_path
      click_link 'Google'
      expect(page).to_not have_content('Sign Out')
    end
  end
end
