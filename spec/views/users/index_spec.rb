require 'rails_helper'

RSpec.describe 'users/index.html.erb', type: :view do
  let(:current_user) { FactoryBot.create(:user, admin: true) }

  before do
    users = [FactoryBot.create(:user), FactoryBot.create(:user)]
    assign(:users, Kaminari.paginate_array(users).page(1))
    allow(view).to receive(:current_user).and_return(current_user)
    render
  end

  it 'displays the users list' do
    expect(rendered).to have_selector('h1', text: 'USERS LIST')

    within '.container' do
      expect(rendered).to have_selector('.card', count: 2)

      @users.each do |user|
        expect(rendered).to have_selector('.card-title', text: "#{user.firstname} #{user.lastname}")
        expect(rendered).to have_selector('.card-text', text: truncate(user.email, length: 200))
        expect(rendered).to have_selector('.card-footer', text: "Created #{time_ago_in_words(user.created_at)} ago, edited #{time_ago_in_words(user.updated_at)} ago")

        if current_user.admin?
          if user.admin?
            expect(rendered).to have_selector('.badge.bg-primary.text-light', text: 'Admin')
          else
            expect(rendered).not_to have_selector('.badge.bg-primary.text-light')
          end

          expect(rendered).to have_link('Delete', href: user_path(user), method: :delete, id: user.id, count: 2)
        else
          expect(rendered).not_to have_link('Delete')
        end
      end
    end

    expect(rendered).to have_selector('.flickr_pagination')
  end
end
