require 'rails_helper'

RSpec.describe 'shops/login.html.erb', type: :view do
  before do
    assign(:shop, Shop.new)
    render
  end

  it 'displays the login form' do
    expect(rendered).to have_selector('h1', text: 'SHOP LOGIN')
    expect(rendered).to have_selector('form[action="/shops/login"][method="post"]')
    expect(rendered).to have_selector('input[name="email"][type="email"]')
    expect(rendered).to have_selector('input[name="password"][type="password"]')
    expect(rendered).to have_selector('input[type="submit"][value="Login"]')
  end
end
