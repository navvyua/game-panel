require 'rails_helper'

feature 'Bug tickets handling' do
  describe 'autorized as user' do
    let(:user) { create(:user) }
    let(:bug_attr) { attributes_for(:bug_ticket) }

    before { sign_in user }

    context 'create bug ticket' do
      scenario 'create bug ticket' do
        visit new_bug_ticket_path

        fill_in(I18n.t('bug_tickets.form.title'), with: bug_attr[:title])
        fill_in(I18n.t('bug_tickets.form.description'), with: bug_attr[:description])
        attach_file('bug_ticket_bug_image', 'spec/support/images/test_image.png')
        click_button 'Create Bug ticket'

        expect(page).to have_content(bug_attr[:title])
      end

      context 'bug ticket show page' do
        let(:bug) { create(:bug_ticket) }

        before { visit bug_ticket_path(bug.id) }

        scenario 'show page should content name' do
          expect(page).to have_content(bug.title)
        end

        scenario 'show page should content description' do
          expect(page).to have_content(bug.description)
        end

        scenario 'show page should content correct status' do
          expect(page).to have_content(bug.status)
        end
      end
    end
  end

  describe 'autorize as admin' do
    let!(:user) { create(:user, :admin) }
    let!(:bug) { create(:bug_ticket, user_id: User.last.id) }

    before { sign_in user }
    before { visit admin_bug_tickets_path }

    context 'admin index page' do
      scenario 'display bug author' do
        expect(page).to have_content(bug.user.email)
      end

      scenario 'display bug title' do
        expect(page).to have_content(bug.title)
      end

      scenario 'display bug status' do
        expect(page).to have_content(bug.status)
      end
    end

    context 'bug show page' do
      before { visit bug_ticket_path(bug.id) }

      scenario 'update bug status', js: true do
        click_on I18n.t('bug_tickets.status_form.status_closed')

        expect(page).to have_content(I18n.t('bug_tickets.status_form.status_closed').downcase)
      end

      scenario 'delete bug' do
        click_link I18n.t('bug_tickets.show.delete')

        expect(page).to have_content(I18n.t('bug_tickets.destroy.ticket_destroyed'))
      end
    end
  end
end
