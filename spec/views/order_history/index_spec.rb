require 'rails_helper'

RSpec.describe 'order_history/index.html.erb', type: :view do
  let(:user) { create(:user) }
  let!(:orders) { create_list(:order, 3, user: user) }

  before do
    allow(view).to receive(:current_user).and_return(user)
    assign(:orders, orders)
    render
  end

  it 'displays the order history heading' do
    expect(rendered).to have_css('h1', text: 'Order History')
  end

  it 'displays the table with order details' do
    expect(rendered).to have_css('table.table')
    expect(rendered).to have_css('thead')
    expect(rendered).to have_css('th', text: 'Order Date')
    expect(rendered).to have_css('th', text: 'Total Amount')
    expect(rendered).to have_css('th', text: 'Status')
    expect(rendered).to have_css('th', text: 'Actions')

    orders.each do |order|
      expect(rendered).to have_css('tbody td', text: order.created_at.to_s)
      expect(rendered).to have_css('tbody td', text: number_to_currency(order.price, unit: '₹'))
      expect(rendered).to have_css('tbody td', text: order.status)
      expect(rendered).to have_link('View', href: order_path(order))
    end
  end

  it 'displays a message when no orders are found' do
    assign(:orders, [])
    render

    expect(rendered).to have_css('p', text: 'No orders found.')
  end
end
