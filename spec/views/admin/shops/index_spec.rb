require 'rails_helper'

RSpec.describe 'admin/shops/index.html.erb', type: :view do
  let(:shop1) { FactoryBot.build_stubbed(:shop, id: 1, name: 'Shop 1', email: 'shop1@example.com', location: 'Location 1', contact_info: 'Contact Info 1') }
  let(:shop2) { FactoryBot.build_stubbed(:shop, id: 2, name: 'Shop 2', email: 'shop2@example.com', location: 'Location 2', contact_info: 'Contact Info 2') }

  before do
    assign(:shops, [shop1, shop2])
    render
  end

  it 'displays the heading' do
    expect(rendered).to have_selector('h2', text: 'SHOPS LIST')
  end

  it 'displays the table headers' do
    expect(rendered).to have_selector('th', text: 'Name')
    expect(rendered).to have_selector('th', text: 'Email')
    expect(rendered).to have_selector('th', text: 'Location')
    expect(rendered).to have_selector('th', text: 'Contact Info')
    expect(rendered).to have_selector('th', text: 'Actions')
  end

  it 'displays the shop details' do
    expect(rendered).to have_selector('td', text: 'Shop 1')
    expect(rendered).to have_selector('td', text: 'shop1@example.com')
    expect(rendered).to have_selector('td', text: 'Location 1')
    expect(rendered).to have_selector('td', text: 'Contact Info 1')
  end

  it 'renders edit and delete buttons for each shop' do
    expect(rendered).to have_selector("a[href='#{edit_admin_shop_path(shop1)}']", text: 'Edit')
    expect(rendered).to have_selector("a[href='#{admin_shop_path(shop1)}'][data-method='delete']", text: 'Delete', count: 1)
    expect(rendered).to have_selector("a[href='#{edit_admin_shop_path(shop2)}']", text: 'Edit')
    expect(rendered).to have_selector("a[href='#{admin_shop_path(shop2)}'][data-method='delete']", text: 'Delete', count: 1)
  end
end
