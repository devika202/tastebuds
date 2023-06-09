require 'rails_helper'

RSpec.describe 'checkout/new', type: :view do
  before(:each) do
    assign(:cart, Cart.new)
    @order = assign(:order, FactoryBot.create(:order))
    render
  end

  it 'displays the checkout header' do
    expect(rendered).to have_css('h1.text-center', text: 'CHECKOUT')
  end

  it 'displays the cart summary section' do
    expect(rendered).to have_css('h2', text: 'Cart Summary')
  end

  context 'when cart is not empty' do
    before(:each) do
      product = create(:product, product_title: 'Product 1') 
      cart_item = create(:cart_item, product: product)
      assign(:cart, Cart.new(cart_items: [cart_item]))
      order_item = FactoryBot.create(:order_item, order: @order, product: product)
      render
    end

    it 'displays the cart items table' do
      expect(rendered).to have_css('table.table')
    end

    it 'displays the cart item details' do
      expect(rendered).to have_css('table.table thead tr th', text: 'Quantity') 
      expect(rendered).to have_css('table.table thead tr th', text: 'Price') 
      expect(rendered).to have_css('table.table thead tr th', text: 'Subtotal') 
    end

    it 'displays the total price' do
      expect(rendered).to have_css('table.table tfoot tr td', text: 'Total:')
    end
  end

  it 'displays the add delivery address section' do
    expect(rendered).to have_css('h2.text-center', text: 'Add Delivery Address')
  end

  it 'displays the order form' do
    expect(rendered).to have_css('form[action="/checkout"][method="post"]')
    expect(rendered).to have_field('order_shipping_name')
    expect(rendered).to have_field('order_shipping_address')
    expect(rendered).to have_field('order_shipping_city')
    expect(rendered).to have_field('order_shipping_state')
    expect(rendered).to have_field('order_shipping_zipcode')
    expect(rendered).to have_field('order_payment_method')
    expect(rendered).to have_button('Place Order')
  end
end
