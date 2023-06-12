require 'rails_helper'

RSpec.describe 'admin/orders/show', type: :view do
  let(:order) { FactoryBot.create(:order) }

  before do
    assign(:order, order)
    render
  end

  it 'displays order details' do
    expect(rendered).to have_content('Order Details')
    expect(rendered).to have_content("Order ID: #{order.id}")
    expect(rendered).to have_content("User: #{order.user.email}")
    expect(rendered).to have_content("Shipping Name: #{order.shipping_name}")
    expect(rendered).to have_content("Shipping Address: #{order.shipping_address}")
    expect(rendered).to have_content("Shipping City: #{order.shipping_city}")
    expect(rendered).to have_content("Shipping State: #{order.shipping_state}")
    expect(rendered).to have_content("Shipping Zipcode: #{order.shipping_zipcode}")
    expect(rendered).to have_content("Payment Method: #{order.payment_method}")
  end

  it 'displays order items' do
    expect(rendered).to have_content('Order Items')
    expect(rendered).to have_selector('table.table')
    expect(rendered).to have_selector('thead')
    expect(rendered).to have_selector('th', text: 'Product Name')
    expect(rendered).to have_selector('th', text: 'Quantity')
    expect(rendered).to have_selector('th', text: 'Price')
    expect(rendered).to have_selector('th', text: 'Total Price')

    order.order_items.each do |order_item|
      expect(rendered).to have_selector('tr')
      expect(rendered).to have_content(order_item.product.product_title)
      expect(rendered).to have_content(order_item.quantity)
      expect(rendered).to have_content(number_to_currency(order_item.product.price, unit: "₹"))
      expect(rendered).to have_content(number_to_currency(order_item.total_price, unit: "₹"))
    end
  end

  it 'displays total amount' do
    expect(rendered).to have_content("Total Amount: #{number_to_currency(order.total_price, unit: '₹')}")
  end

  context 'when order status is delivered' do
    before do
      order.update(status: 'delivered')
      render
    end

    it 'displays order status and All Orders link' do
      expect(rendered).to have_content('Order status: delivered')
      expect(rendered).to have_link('All Orders', href: admin_orders_path, class: 'btn btn-primary')
    end
  end

  context 'when order status is not delivered' do
    before do
      order.update(status: 'pending')
      render
    end

    it 'displays order status, All Orders link, and Edit Order Status link' do
      expect(rendered).to have_content('Status: pending')
      expect(rendered).to have_link('All Orders', href: admin_orders_path, class: 'btn btn-primary')
      expect(rendered).to have_link('Edit Order Status', href: edit_admin_order_path(order), class: 'btn btn-primary')
    end
  end
end
