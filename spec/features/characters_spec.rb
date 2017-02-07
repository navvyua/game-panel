require 'rails_helper'

feature 'Characters' do
  let(:user)              { create(:user) }
  let(:new_character)     { build(:character) }
  let(:invalid_character) { build(:character, :invalid) }

  before { sign_in user }

  context 'with valid params' do
    scenario 'user creates character' do
      click_link 'Create character'
      fill_in 'character_first_name', with: new_character.first_name
      fill_in 'character_last_name', with: new_character.last_name
      fill_in 'character_age', with: new_character.age
      fill_in 'character_biography', with: new_character.biography
      click_button 'Create'
      expect(page).to have_content(I18n.t('characters.character.validating'))
    end
  end

  context 'with invalid params' do
    scenario 'user creates character' do
      click_link 'Create character'
      fill_in 'character_first_name', with: invalid_character.first_name
      fill_in 'character_last_name', with: invalid_character.last_name
      fill_in 'character_age', with: invalid_character.age
      fill_in 'character_biography', with: invalid_character.biography
      click_button 'Create'
      expect(page).to_not have_content(I18n.t('characters.character.validating'))
    end
  end
end
