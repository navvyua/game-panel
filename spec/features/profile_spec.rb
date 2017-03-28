require 'rails_helper'

feature 'profile' do
  let(:user) { create(:user) }
  before do
    sign_in user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user.decorate)
    visit profile_user_path(user.id)
  end

  describe 'Update profile' do
    let(:user_attrs) { attributes_for(:user, :full) }

    scenario 'user update profile' do
      basic_fields = %i(email name first_name last_name age about)

      click_button I18n.t('users.edit_dialog.edit')
      basic_fields.each do |field|
        fill_in "user[#{field}]", with: user[field]
      end
      page.select 'Georgia', from: 'user[location]'
      attach_file('user[avatar]', "#{Rails.root}/spec/support/images/test_image.png")
      click_button I18n.t('users.edit_dialog.submit')

      expect(page).to have_content(user.about)
    end
  end

  describe 'Displaying avatar' do
    context 'default' do
      scenario 'display default avatar' do
        expect(find('.profile-user-img')['src']).to include('default_avatar')
      end
    end

    context 'users' do
      scenario 'display users avatar' do
        click_button I18n.t('users.edit_dialog.edit')
        attach_file('user[avatar]', "#{Rails.root}/spec/support/images/test_image.png")
        click_button I18n.t('users.edit_dialog.submit')

        expect(find('.profile-user-img')['src']).to include('test_image')
      end
    end
  end
end
