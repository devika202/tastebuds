require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    @order = assign(:order, FactoryBot.create(:order))
  end

  it "displays the order summary" do
    render

    expect(rendered).to have_selector('h1', text: 'Order Summary')
    expect(rendered).to have_content("Order ID: #{@order.id}")
    expect(rendered).to have_content("Total: #{number_to_currency(@order.price, unit: '₹')}")
  end

  it "displays the order details" do
    render

    expect(rendered).to have_selector('.card-body', text: 'Order Details')
    expect(rendered).to have_content("Shipping Name: #{@order.shipping_name}")
    expect(rendered).to have_content("Shipping Address: #{@order.shipping_address}")
    expect(rendered).to have_content("Shipping City: #{@order.shipping_city}")
    expect(rendered).to have_content("Shipping State: #{@order.shipping_state}")
    expect(rendered).to have_content("Shipping Zipcode: #{@order.shipping_zipcode}")
    expect(rendered).to have_content("Payment Method: #{@order.payment_method}")
  end

  it "displays the order items" do
    order_item1 = FactoryBot.create(:order_item, order: @order)
    order_item2 = FactoryBot.create(:order_item, order: @order)

    render

    expect(rendered).to have_selector('h5', text: 'Order Items')
    expect(rendered).to have_selector('table')
    expect(rendered).to have_content(order_item1.product.product_title)
    expect(rendered).to have_content(order_item1.quantity)
    expect(rendered).to have_content(number_to_currency(order_item1.product.price, unit: '₹'))
    expect(rendered).to have_content(number_to_currency(order_item1.total_price, unit: '₹'))
    expect(rendered).to have_content(order_item2.product.product_title)
    expect(rendered).to have_content(order_item2.quantity)
    expect(rendered).to have_content(number_to_currency(order_item2.product.price, unit: '₹'))
    expect(rendered).to have_content(number_to_currency(order_item2.total_price, unit: '₹'))
  end

  it "displays the total amount and status" do
    render

    expect(rendered).to have_content("Total Amount: #{number_to_currency(@order.total_price, unit: '₹')}")
    expect(rendered).to have_content("Status: #{@order.status}")
  end
end
