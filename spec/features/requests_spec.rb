require 'rails_helper'

feature 'Help center' do
  let(:user)     { create :user, :admin }
  let!(:request) { create :request, user: user }
  let(:comment_attrs)         { attributes_for :comment }
  let(:valid_request_attrs)   { attributes_for :request }
  let(:invalid_request_attrs) { attributes_for :request, :invalid }

  before { sign_in user }

  describe 'user creates request' do
    scenario 'with valid params' do
      click_link I18n.t('shared.sidebar.create_help_request')
      fill_in 'request_description', with: valid_request_attrs[:description]
      click_button I18n.t('helpers.submit.create', model: Request)
      expect(page).to have_content(valid_request_attrs[:description])
    end

    scenario 'with invalid params' do
      click_link I18n.t('shared.sidebar.create_help_request')
      fill_in 'request_description', with: invalid_request_attrs[:description]
      click_button I18n.t('helpers.submit.create', model: Request)
      expect(page).to have_content I18n.t('requests.new.title')
    end
  end

  describe 'user side' do
    before { click_link I18n.t('shared.sidebar.my_help_requests') }

    scenario 'user replies in request' do
      click_link '#'
      fill_in 'comment_text', with: comment_attrs[:text]
      click_button I18n.t('requests.show.reply')
      expect(page).to have_content comment_attrs[:text]
    end

    scenario 'user closes request from index' do
      click_link I18n.t('requests.request.close')
      expect(page).to have_content I18n.t('requests.index.dont_have_requests')
    end

    scenario 'user closes request from request page' do
      click_link '#'
      click_link I18n.t('requests.show.close')
      expect(page).to have_content I18n.t('requests.index.dont_have_requests')
    end
  end

  describe 'admin side' do
    before { click_link I18n.t('shared.sidebar.help_requests') }

    scenario 'admin processes request' do
      click_link I18n.t('admin.requests.request.process')
      expect(page).to have_link I18n.t('requests.show.close')
    end

    scenario 'shows requests which processing by admin' do
      click_link I18n.t('admin.requests.request.process')
      click_link I18n.t('shared.sidebar.help_requests')
      expect(page).to have_content I18n.t('admin.requests.index.processing_requests')
    end

    scenario 'admin deletes request' do
      click_link I18n.t('admin.requests.request.delete')
      expect(page).to have_content I18n.t('admin.requests.index.no_available_requests')
    end

    scenario 'admin replies in request' do
      click_link I18n.t('admin.requests.request.process')
      fill_in 'comment_text', with: comment_attrs[:text]
      click_button I18n.t('requests.show.reply')
      expect(page).to have_content comment_attrs[:text]
    end
  end

  it 'shows available requests counter for admins in sidebar' do
    expect(page).to have_content "#{I18n.t('shared.sidebar.help_requests')}1"
  end
end
