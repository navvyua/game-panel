require 'rails_helper'

feature 'News' do
  describe 'autorized as user' do
    let(:user) { create :user }
    let!(:news) { create :news, user_id: user.id }
    let(:title) { attributes_for(:news)['title'] }

    before(:each) do
      sign_in user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit news_index_path
    end

    describe 'news list page' do
      before { visit news_index_path }

      context 'autirized as user' do
        scenario 'contains news' do
          expect(page).to have_content(title)
        end

        scenario 'does not contain add button' do
          expect(page).not_to have_button(I18n.t('news.news_dialog.add_news'))
        end

        scenario 'moves to chosen news page' do
          click_link news.title

          expect(page).to have_content(title)
        end
      end
    end

    describe 'news page' do
      before { visit news_path(news.id) }

      context 'does not contain' do
        scenario 'edit button' do
          expect(page).not_to have_button(I18n.t('news.show.edit'))
        end

        scenario 'delete button' do
          expect(page).not_to have_button(I18n.t('news.show.delete'))
        end
      end
    end
  end

  describe 'autorized as admin' do
    let(:user) { create :user, role: 2 }
    let!(:news) { create :news, user_id: user.id }
    let(:title) { attributes_for(:news)['title'] }
    let(:new_title) { I18n.t('news.tests.new_title') }
    let(:edit_title) { I18n.t('news.tests.edit_title') }

    before(:each) do
      sign_in user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    describe 'news list page' do
      before { visit news_index_path }

      scenario 'contains news' do
        expect(page).to have_content(title)
      end

      scenario 'contain add button' do
        expect(page).to have_button(I18n.t('news.news_dialog.add_news'))
      end

      scenario 'chosen news page' do
        click_link news.title

        expect(page).to have_content(title)
      end

      scenario 'create new news' do
        click_button I18n.t('news.news_dialog.add_news')
        fill_in('Title', with: new_title)
        fill_in('Text', with: Faker::Hipster.paragraphs(5).to_s)
        attach_file('news_news_image', 'spec/support/images/test_image.png')
        click_button I18n.t('news.news_dialog.submit')

        expect(page).to have_content(new_title)
      end
    end

    describe 'news page' do
      before { visit news_path(news.id) }

      scenario 'edit button' do
        expect(page).to have_button(I18n.t('news.show.edit'))
      end

      scenario 'delete button' do
        expect(page).to have_content(I18n.t('news.show.delete'))
      end

      scenario 'admin can edit news' do
        click_button I18n.t('news.show.edit')
        fill_in('Title', with: edit_title)
        attach_file('news_news_image', 'spec/support/images/test_image.png')
        click_button I18n.t('news.news_dialog.submit')

        expect(page).to have_content(edit_title)
      end

      scenario 'admin can delete news' do
        click_link I18n.t('news.show.delete')

        expect(page).not_to have_content(edit_title)
      end
    end
  end
end
