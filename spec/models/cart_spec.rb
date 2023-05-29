require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:category) { create(:category) }
  let(:product) { create(:product, category_ids: category.id, image: fixture_file_upload('app/assets/images/download.jpg', 'image/jpeg')) }


  describe '#total_price' do
    it 'returns the sum of total prices of cart items' do
      cart_item1 = create(:cart_item, cart: cart, product: product, quantity: 2)
      cart_item2 = create(:cart_item, cart: cart, product: product, quantity: 3)
      expected_total_price = cart_item1.total_price + cart_item2.total_price
      expect(cart.total_price).to eq(expected_total_price)
    end
  end

  describe '#add_item' do
    it 'adds a new item to the cart' do
      expect { cart.add_item(product.id) }.to change { cart.cart_items.count }.from(0).to(1)
    end

    it 'increments the quantity of an existing item' do
      cart_item = create(:cart_item, cart: cart, product: product, quantity: 2)
      expect { cart.add_item(product.id) }.to change { cart_item.reload.quantity }.from(2).to(3)
    end
  end

  describe '#remove_item' do
    it 'decrements the quantity of an existing item' do
      cart_item = create(:cart_item, cart: cart, product: product, quantity: 2)
      expect { cart.remove_item(product.id) }.to change { cart_item.reload.quantity }.from(2).to(1)
    end

    it 'destroys the item if its quantity becomes 0' do
      cart_item = create(:cart_item, cart: cart, product: product, quantity: 1)
      expect { cart.remove_item(product.id) }.to change { CartItem.count }.from(1).to(0)
    end
  end
end
