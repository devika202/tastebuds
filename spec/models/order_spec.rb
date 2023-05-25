require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "associations" do
    it "belongs to a user" do
      expect(Order.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "has many order items" do
      expect(Order.reflect_on_association(:order_items).macro).to eq(:has_many)
    end

    it "has one accounting" do
      expect(Order.reflect_on_association(:accounting).macro).to eq(:has_one)
    end

    it "has many products through order items" do
      expect(Order.reflect_on_association(:products).macro).to eq(:has_many)
      expect(Order.reflect_on_association(:products).options[:through]).to eq(:order_items)
    end
  end

  describe "enums" do
    it "defines the status enum" do
      expect(Order.statuses).to include("pending", "processing", "shipped", "delivered")
    end
  end


#   describe "methods" do
#     let(:order) { Order.new }

#     it "creates order items from cart items" do
#         product1 = double("Product", price: 10)
#         product2 = double("Product", price: 15)
#         cart_item1 = double("CartItem", product_title: "Product 1", quantity: 2, product: product1)
#         cart_item2 = double("CartItem", product_title: "Product 2", quantity: 1, product: product2)
#         cart_items = [cart_item1, cart_item2]
  
#         expect {
#           order.create_order_items(cart_items)
#         }.to change { OrderItem.count }.by(2)
  
#         expect(order.order_items.first.product_title).to eq("Product 1")
#         expect(order.order_items.first.quantity).to eq(2)
#         expect(order.order_items.first.price).to eq(10)
  
#         expect(order.order_items.last.product_title).to eq("Product 2")
#         expect(order.order_items.last.quantity).to eq(1)
#         expect(order.order_items.last.price).to eq(15)
#       end
      

#     it "calculates the total price of the order" do
#       order_item1 = double("OrderItem", total_price: 20)
#       order_item2 = double("OrderItem", total_price: 15)
#       allow(order).to receive(:order_items).and_return([order_item1, order_item2])

#       expect(order.total_price).to eq(35)
#     end

#     it "calculates the price of the order" do
#       order_item1 = double("OrderItem", quantity: 2, product: double("Product", price: 10))
#       order_item2 = double("OrderItem", quantity: 1, product: double("Product", price: 15))
#       allow(order).to receive(:order_items).and_return([order_item1, order_item2])

#       expect(order.price).to eq(35)
#     end
#   end

  describe "validations" do
    it "validates presence of shipping name" do
      expect(subject).to validate_presence_of(:shipping_name)
    end

    it "validates presence of shipping address" do
      expect(subject).to validate_presence_of(:shipping_address)
    end

    it "validates presence of shipping city" do
      expect(subject).to validate_presence_of(:shipping_city)
    end

    it "validates presence of shipping state" do
      expect(subject).to validate_presence_of(:shipping_state)
    end

    it "validates presence of shipping zipcode" do
      expect(subject).to validate_presence_of(:shipping_zipcode)
    end

    it "validates the length of shipping zipcode" do
      expect(subject).to validate_length_of(:shipping_zipcode).is_at_least(5).is_at_most(9)
    end

    it "validates presence of payment method" do
      expect(subject).to validate_presence_of(:payment_method)
    end
  end
end
