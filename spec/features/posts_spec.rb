require 'rails_helper'

feature 'Posts' do
  describe 'autorized as user' do
    let(:user)  { create :user }
    let!(:post) { create :post, user_id: user.id }
    let(:title) { attributes_for(:post)['title'] }

    before(:each) do
      sign_in user
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user.decorate)
      visit posts_path
    end

    describe 'posts list page' do
      before { visit posts_path }

      context 'autirized as user' do
        scenario 'contains post' do
          expect(page).to have_content(title)
        end

        scenario 'does not contain add button' do
          expect(page).not_to have_button(I18n.t('posts.post_dialog.add_post'))
        end

        scenario 'moves to chosen post page' do
          click_link post.title
          expect(page).to have_content(title)
        end
      end
    end

    describe 'post page' do
      before { visit post_path(post.id) }

      context 'does not contain' do
        scenario 'edit button' do
          expect(page).not_to have_button(I18n.t('posts.show.edit'))
        end

        scenario 'delete button' do
          expect(page).not_to have_button(I18n.t('posts.show.delete'))
        end
      end
    end
  end

  describe 'autorized as admin' do
    let(:user) { create :user, role: 2 }
    let!(:post) { create :post, user_id: user.id }
    let(:title) { attributes_for(:post)['title'] }
    let(:new_title) { I18n.t('posts.tests.new_title') }
    let(:edit_title) { I18n.t('posts.tests.edit_title') }

    before(:each) do
      sign_in user
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user.decorate)
    end

    describe 'post list page' do
      before { visit posts_path }

      scenario 'contains post' do
        expect(page).to have_content(title)
      end

      scenario 'contain add button' do
        expect(page).to have_button(I18n.t('posts.post_dialog.add_post'))
      end

      scenario 'chosen post page' do
        click_link post.title

        expect(page).to have_content(title)
      end

      scenario 'create new post' do
        click_button I18n.t('posts.post_dialog.add_post')
        fill_in('Title', with: new_title)
        fill_in('Text', with: Faker::Hipster.paragraphs(5).to_s)
        attach_file('post_post_image', 'spec/support/images/test_image.png')
        click_button I18n.t('helpers.submit.create', model: Post)

        expect(page).to have_content(new_title)
      end
    end

    describe 'post page' do
      before { visit post_path(post.id) }

      scenario 'edit button' do
        expect(page).to have_button(I18n.t('posts.show.edit'))
      end

      scenario 'delete button' do
        expect(page).to have_content(I18n.t('posts.show.delete'))
      end

      scenario 'admin can edit post' do
        click_button I18n.t('posts.show.edit')
        fill_in('Title', with: edit_title)
        attach_file('post_post_image', 'spec/support/images/test_image.png')
        click_button I18n.t('helpers.submit.update', model: Post)

        expect(page).to have_content(edit_title)
      end

      scenario 'admin can delete post' do
        click_link I18n.t('posts.show.delete')

        expect(page).not_to have_content(edit_title)
      end
    end
  end
end
