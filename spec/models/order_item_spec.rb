require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  include FactoryBot::Syntax::Methods

  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:order) { create(:order, user: user, shipping_name: "John Doe", shipping_address: "123 Main St", shipping_city: "City", shipping_state: "State", shipping_zipcode: "12345", payment_method: "Credit Card") }
  let(:product) { create(:product, category_ids: category.id, image: fixture_file_upload('app/assets/images/download.jpg', 'image/jpeg')) }
  let(:order_item) { create(:order_item, order: order, product: product) }

  describe '#total_price' do
    it 'calculates the total price based on quantity and product price' do
      order_item.quantity = 2
      product.price = 10.0

      expect(order_item.total_price).to eq(20.0)
    end
  end

  describe 'associations' do
    it { should belong_to(:order).required }
    it { should belong_to(:product).required }
  end
end
