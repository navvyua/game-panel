require 'rails_helper'

feature 'Default authentication' do
  let(:user)             { create(:user) }
  let(:new_user)         { build(:user) }
  let(:new_invalid_user) { build(:user, :invalid) }

  scenario 'user signs out' do
    sign_in user
    click_link 'Sign Out'
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'user moves from sign in to sign up page' do
    visit sign_in_path
    click_link 'Sign Up'
    expect(page).to have_button('Sign Up')
  end

  scenario 'user moves from sign up to sign in page' do
    visit sign_up_path
    click_link 'Sign In'
    expect(page).to have_button('Sign In')
  end

  context 'with valid params' do
    scenario 'user signs in' do
      sign_in user
      expect(page).to have_content('Sign Out')
    end

    scenario 'user signs up' do
      sign_up new_user
      expect(page).to have_content('Sign Out')
    end
  end

  context 'with invalid params' do
    scenario 'user signs in' do
      sign_in new_invalid_user
      expect(page).to_not have_content('Sign Out')
    end

    scenario 'user signs up' do
      sign_up new_invalid_user
      expect(page).to_not have_content('Sign Out')
    end
  end
end
