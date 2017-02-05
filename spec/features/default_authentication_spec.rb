require 'rails_helper'

feature 'Default authentication' do
  let(:user)             { create(:user) }
  let(:new_user)         { build(:user) }
  let(:new_invalid_user) { build(:user, :invalid) }

  scenario 'user signs out' do
    sign_in user
    click_link I18n.t('shared.header.sign_out')
    expect(page).to_not have_content(I18n.t('shared.header.sign_out'))
  end

  scenario 'user moves from sign in to sign up page' do
    visit sign_in_path
    click_link I18n.t('sessions.new.sign_up_here')
    expect(page).to have_button(I18n.t('users.new.sign_up'))
  end

  scenario 'user moves from sign up to sign in page' do
    visit sign_up_path
    click_link I18n.t('sessions.new.already_have_account')
    expect(page).to have_button(I18n.t('sessions.new.sign_in'))
  end

  context 'with valid params' do
    scenario 'user signs in' do
      sign_in user
      expect(page).to have_content(I18n.t('shared.header.sign_out'))
    end

    scenario 'user signs up' do
      sign_up new_user
      expect(page).to have_content(I18n.t('shared.header.sign_out'))
    end
  end

  context 'with invalid params' do
    scenario 'user signs in' do
      sign_in new_invalid_user
      expect(page).to_not have_content(I18n.t('shared.header.sign_out'))
    end

    scenario 'user signs up' do
      sign_up new_invalid_user
      expect(page).to_not have_content(I18n.t('shared.header.sign_out'))
    end
  end
end
