require 'rails_helper'

RSpec.describe 'orders/order_confirmation', type: :view do
  before(:each) do
    @order = FactoryBot.create(:order)
    assign(:order, @order)
  end

  it 'displays order confirmation details' do
    render

    expect(rendered).to have_content('Order Confirmation')
    expect(rendered).to have_content('Your order has been received.')
    expect(rendered).to have_content("Order ID: #{@order.id}")
    expect(rendered).to have_content("Total: #{number_to_currency(@order.price, unit: '₹')}")

    expect(rendered).to have_content('Order Details')
    expect(rendered).to have_content("Shipping Name: #{@order.shipping_name}")
    expect(rendered).to have_content("Shipping Address: #{@order.shipping_address}")
    expect(rendered).to have_content("Shipping City: #{@order.shipping_city}")
    expect(rendered).to have_content("Shipping State: #{@order.shipping_state}")
    expect(rendered).to have_content("Shipping Zipcode: #{@order.shipping_zipcode}")
    expect(rendered).to have_content("Payment Method: #{@order.payment_method}")

    expect(rendered).to have_content('ORDER ITEMS')
    expect(rendered).to have_css('table.table')
    expect(rendered).to have_css('table.table-striped')
    expect(rendered).to have_css('table.table-bordered')
    expect(rendered).to have_css('table.table-hover')

    @order.order_items.each do |item|
      expect(rendered).to have_content(item.product.product_title)
      expect(rendered).to have_content(item.quantity)
      expect(rendered).to have_content(number_to_currency(item.product.price, unit: '₹'))
      expect(rendered).to have_content(number_to_currency(item.total_price, unit: '₹'))
    end

    expect(rendered).to have_content("Total Amount: #{number_to_currency(@order.total_price, unit: '₹')}")
    expect(rendered).to have_content("Status: #{@order.status}")
  end
end
