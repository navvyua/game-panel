require 'rails_helper'

# rubocop:disable Metrics/BlockLength
feature 'Facebook authentication' do
  context 'with valid hash' do
    before(:each) do
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: 'facebook',
        uid: Faker::Number.number(8),
        info: { email: Faker::Internet.email }
      )
    end

    scenario 'user signs in' do
      visit sign_in_path
      click_link 'Facebook'
      expect(page).to have_content('Sign Out')
    end

    scenario 'user signs up' do
      visit sign_up_path
      click_link 'Facebook'
      expect(page).to have_content('Sign Out')
    end

    scenario 'user signs out' do
      visit sign_in_path
      click_link 'Facebook'
      click_link 'Sign Out'
      expect(page).to_not have_content('Sign Out')
    end
  end

  context 'with invalid hash' do
    before(:each) do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    end

    scenario 'user signs in' do
      visit sign_in_path
      click_link 'Facebook'
      expect(page).to_not have_content('Sign Out')
    end

    scenario 'user signs up' do
      visit sign_up_path
      click_link 'Facebook'
      expect(page).to_not have_content('Sign Out')
    end
  end
end
