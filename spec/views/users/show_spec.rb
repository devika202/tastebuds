require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }

  before(:each) do
    @user = assign(:user, user)
    allow(view).to receive(:current_user).and_return(nil)
  end

  it 'displays user details' do
    render

    expect(rendered).to have_selector('h2', text: 'USER DETAILS')
    expect(rendered).to have_selector('img.gravatar')
    expect(rendered).to have_selector('p', text: "FIRSTNAME : #{user.firstname}")
    expect(rendered).to have_selector('p', text: "LASTNAME : #{user.lastname}")
    expect(rendered).to have_selector('p', text: "ADDRESS : #{user.address}")
    expect(rendered).to have_selector('p', text: "PHONE : #{user.phone}")
    expect(rendered).to have_selector('p', text: "E-MAIL : #{user.email}")
    expect(rendered).to have_selector('p', text: "USERNAME : #{user.username}")

    expect(rendered).to have_link('Edit', href: edit_user_registration_path)
    expect(rendered).to have_link('Delete', href: user_path(user), class: 'btn btn-danger', id: user.id, data: { confirm: 'Are you sure?' })
    expect(rendered).to have_link('Back', href: root_path)
  end

  context 'when current user is an admin' do
    before(:each) do
      allow(view).to receive(:current_user).and_return(admin)
    end

    it 'displays edit and delete links' do
      render

      expect(rendered).to have_link('Edit', href: edit_user_registration_path)
      expect(rendered).to have_link('Delete', href: user_path(user), class: 'btn btn-danger', id: user.id, data: { confirm: 'Are you sure?' })
      expect(rendered).to have_link('Back', href: root_path)
    end
  end

  context 'when current user is the same as the displayed user' do
    before(:each) do
      allow(view).to receive(:current_user).and_return(user)
    end

    it 'displays edit and delete links' do
      render

      expect(rendered).to have_link('Edit', href: edit_user_registration_path)
      expect(rendered).to have_link('Delete', href: user_path(user), class: 'btn btn-danger', id: user.id, data: { confirm: 'Are you sure?' })
      expect(rendered).to have_link('Back', href: root_path)
    end
  end
end
