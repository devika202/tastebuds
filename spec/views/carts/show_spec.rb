require 'rails_helper'

RSpec.describe 'carts/show.html.erb', type: :view do
  before do
    assign(:cart, create(:cart))
    render
  end

  it 'displays the cart title' do
    expect(rendered).to have_css('h1', text: 'YOUR CART')
  end

  it 'displays the cart items' do
    expect(rendered).to have_css('.card', count: 1) 

    within('.card') do
      expect(rendered).to have_css('.card-title', text: 'Product Title')
      expect(rendered).to have_css('.card-text', text: 'Quantity: 1')
      expect(rendered).to have_css('.card-text', text: 'Price per item: ₹10.00')
      expect(rendered).to have_css('.card-text', text: 'Total price: ₹10.00')
      expect(rendered).to have_link('Remove', href: remove_item_path(item.product), class: 'btn btn-danger')
    end
  end

  it 'displays the cart total' do
    expect(rendered).to have_css('.card', count: 1) 

    within('.card:last-child') do
      expect(rendered).to have_css('.card-title', text: 'Cart Total: ₹10.00')
      expect(rendered).to have_link('Clear Cart', href: clear_cart_path, class: 'btn btn-danger')
      expect(rendered).to have_link('Continue Shopping', href: products_path, class: 'btn btn-primary')
      expect(rendered).to have_link('Checkout', href: checkout_path, class: 'btn btn-success')
    end
  end
end
