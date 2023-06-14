require 'rails_helper'

RSpec.describe 'admin/orders/edit', type: :view do
  before(:each) do
    @order = FactoryBot.create(:order)
    @product = FactoryBot.create(:product)  
    @order_item = FactoryBot.create(:order_item, order: @order, product: @product) 
    assign(:order, @order)
  end

  it 'renders the edit order form' do 
    render

    expect(rendered).to have_content('Edit Order Status')
    expect(rendered).to have_content('Order ID')
    expect(rendered).to have_content('User')
    expect(rendered).to have_selector('h2', text: 'Order Items')
    expect(rendered).to have_selector('th', text: 'Product Name')
    expect(rendered).to have_selector('th', text: 'Quantity')
    expect(rendered).to have_selector('th', text: 'Price')
    expect(rendered).to have_selector('th', text: 'Total Price')
    expect(rendered).to have_selector('td', text: @order.order_items.first.product.product_title)
    expect(rendered).to have_selector('td', text: @order.order_items.first.quantity.to_s)
    expect(rendered).to have_selector('td', text: number_to_currency(@order.order_items.first.product.price, unit: '₹'))
    expect(rendered).to have_selector('td', text: number_to_currency(@order.order_items.first.total_price, unit: '₹'))
    expect(rendered).to have_selector('label[for="order_status"]', text: 'Status')
    expect(rendered).to have_selector('select[name="order[status]"]')
    expect(rendered).to have_selector('input[type="submit"][value="Update"]')
  end

  context 'when order status is "delivered"' do
    before(:each) do
      @order.update(status: 'delivered')
      render
    end

    it 'renders the order status and All Orders button' do
      expect(rendered).to have_selector('p', text: 'Order status: delivered')
      expect(rendered).to have_selector('a.btn.btn-primary', text: 'All Orders')
    end

    it 'does not render the form' do
      expect(rendered).not_to have_selector('form')
    end
  end

  context 'when order status is not "delivered"' do
    before(:each) do
      @order.update(status: 'pending')
      render
    end

    it 'renders the order status form' do
      expect(rendered).to have_selector('form[action="' + admin_order_path(@order) + '"][method="post"]') do
        expect(rendered).to have_select('order_status', name: 'order[status]')
        expect(rendered).to have_selector('input[type="submit"][value="Update"]')
    end
    end

    it 'does not render the order status and All Orders button' do
      expect(rendered).not_to have_selector('p', text: 'Order status: delivered')
      expect(rendered).not_to have_selector('a.btn.btn-primary', text: 'All Orders')
    end
  end
end
