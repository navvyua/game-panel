require 'rails_helper'

feature 'Character validation' do
  let!(:user)          { create(:user, :admin) }
  let!(:character)     { create(:character, user: user) }
  let(:new_first_name) { attributes_for(:character)[:first_name] }

  before { sign_in user }

  scenario 'user accepts character application' do
    click_link   I18n.t('shared.sidebar.character_validation')
    click_button I18n.t('admin.characters.character.accept')
    click_link   I18n.t('shared.sidebar.my_characters')
    expect(page).to have_link(I18n.t('characters.character.more'))
  end

  scenario 'user denies character application' do
    click_link   I18n.t('shared.sidebar.character_validation')
    click_button I18n.t('admin.characters.character.deny')
    click_link   I18n.t('shared.sidebar.my_characters')
    expect(page).to have_content(I18n.t('characters.character.denied'))
  end

  scenario 'user edits character application' do
    click_link   I18n.t('shared.sidebar.character_validation')
    click_button I18n.t('admin.characters.character.deny')
    click_link   I18n.t('shared.sidebar.my_characters')
    click_link   I18n.t('characters.character.edit')
    fill_in 'character_first_name', with: new_first_name
    click_button I18n.t('helpers.submit.update', model: Character)
    expect(page).to have_content(I18n.t('characters.character.validating'))
  end
end
