require 'rails_helper'

RSpec.describe 'admin/new_shop.html.erb', type: :view do
  before do
    assign(:shop, Shop.new)
    render
  end

  it 'displays the form' do
    expect(rendered).to have_selector('form', count: 1)
  end

  it 'displays the form fields' do
    expect(rendered).to have_selector('form') do |form|
      expect(form).to have_selector('input[type="text"][name="shop[name]"]')
      expect(form).to have_selector('input[type="email"][name="shop[email]"]')
      expect(form).to have_selector('input[type="text"][name="shop[location]"]')
      expect(form).to have_selector('input[type="text"][name="shop[contact_info]"]')
      expect(form).to have_selector('input[type="password"][name="shop[password]"]')
      expect(form).to have_selector('input[type="password"][name="shop[password_confirmation]"]')
      expect(form).to have_selector('input[type="submit"][value="Register Shop"]')
    end
  end

  it 'displays error messages if there are any' do
    shop = Shop.new
    shop.errors.add(:name, 'Name is required')
    shop.errors.add(:email, 'Email is required')

    assign(:shop, shop)
    render

    expect(rendered).to have_selector('#error_explanation')
    expect(rendered).to have_selector('ul li', count: 2)
    expect(rendered).to have_content('Name is required')
    expect(rendered).to have_content('Email is required')
  end
end
