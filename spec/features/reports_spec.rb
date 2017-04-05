require 'rails_helper'

feature 'Reports' do
  let!(:user)  { create :user }
  let!(:admin) { create :user, :admin }

  let!(:admin_character) { create :character, user: admin }

  let!(:report) { create :report, user: user, character: admin_character }

  let(:comment_attrs)        { attributes_for :comment }
  let(:valid_report_attrs)   { attributes_for :report }
  let(:invalid_report_attrs) { attributes_for :report, :invalid }

  describe 'user' do
    before { sign_in user }

    describe 'creates report' do
      before { click_link I18n.t('shared.sidebar.create_report') }

      scenario 'with valid params' do
        fill_in 'report_description', with: valid_report_attrs[:description]
        fill_in 'character_name', with: admin_character.last_name
        attach_file('report_images', 'spec/support/images/test_image.png')

        click_button I18n.t('helpers.submit.create', model: Report)

        expect(page).to have_content(valid_report_attrs[:description])
      end

      scenario 'with invalid params' do
        fill_in 'report_description', with: invalid_report_attrs[:description]
        click_button I18n.t('helpers.submit.create', model: Report)

        expect(page).to have_content I18n.t('reports.new.title')
      end
    end
  end

  describe 'admin' do
    before { sign_in admin }

    describe 'user reports page' do
      before { click_link I18n.t('shared.sidebar.user_reports') }

      scenario 'has opened reports in admin reports page' do
        expect(page).to have_link I18n.t('admin.reports.report.show')
      end

      scenario 'deletes report' do
        click_link I18n.t('admin.reports.report.delete')

        expect(page).to_not have_link I18n.t('admin.reports.report.show')
      end
    end

    scenario 'has received report in my reports page' do
      expect(page).to_not have_content I18n.t('reports.index.are_not_reported')
    end

    scenario 'has opened reports counter in sidebar' do
      expect(page).to have_content "#{I18n.t('shared.sidebar.user_reports')}1"
    end
  end
end
