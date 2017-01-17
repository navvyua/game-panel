require 'rails_helper'

feature 'Authentication authorization' do
  let(:user) { create(:user) }

  context 'authenticated user' do
    before(:each) { sign_in user }

    scenario 'moves to sign_up page' do
      visit sign_up_path
      expect(page).to have_current_path(profile_user_path(user))
    end

    scenario 'moves to sign_in page' do
      visit sign_in_path
      expect(page).to have_current_path(profile_user_path(user))
    end
  end

  context 'unauthenticated user' do
    scenario 'moves to authenticated users only page' do
      visit profile_user_path(user)
      expect(page).to have_current_path(sign_in_path)
    end
  end
end
