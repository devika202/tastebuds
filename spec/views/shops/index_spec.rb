require 'rails_helper'

RSpec.describe 'shops/index.html.erb', type: :view do
  before(:each) do
    assign(:shops, [])
    render
  end

  it 'displays the title' do
    expect(rendered).to have_css('h1.text-center.mt-4', text: 'OUTLETS')
  end

  it 'displays shop information' do
    expect(rendered).to have_css('div.container')
    expect(rendered).to have_css('div.row.justify-content-center')
    expect(rendered).to have_css('div.col-10')

    expect(rendered).not_to have_css('div.card.text-center.mb-3')

    shop = Shop.new(name: 'Shop Name', email: 'shop@example.com', location: 'Shop Location', contact_info: 'Shop Contact Info')
    assign(:shops, [shop])
    render

    expect(rendered).to have_css('div.card.text-center.mb-3', count: 1)
    expect(rendered).to have_css('div.card-header', text: 'Shop Name')
    expect(rendered).to have_css('p', text: 'Email: shop@example.com')
    expect(rendered).to have_css('p', text: 'Location: Shop Location')
    expect(rendered).to have_css('p', text: 'Contact Info: Shop Contact Info')
  end
end
