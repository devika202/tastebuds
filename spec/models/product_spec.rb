require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "associations" do
    it "has many order_items" do
      expect(Product.reflect_on_association(:order_items).macro).to eq(:has_many)
    end

    it "has many orders through order_items" do
      expect(Product.reflect_on_association(:orders).macro).to eq(:has_many)
      expect(Product.reflect_on_association(:orders).through_reflection.name).to eq(:order_items)
    end

    it "has many product_categories" do
      expect(Product.reflect_on_association(:product_categories).macro).to eq(:has_many)
    end

    it "has many categories through product_categories" do
      expect(Product.reflect_on_association(:categories).macro).to eq(:has_many)
      expect(Product.reflect_on_association(:categories).through_reflection.name).to eq(:product_categories)
    end

    it "has many cart_items" do
      expect(Product.reflect_on_association(:cart_items).macro).to eq(:has_many)
    end

    it "has many carts through cart_items" do
      expect(Product.reflect_on_association(:carts).macro).to eq(:has_many)
      expect(Product.reflect_on_association(:carts).through_reflection.name).to eq(:cart_items)
    end

    it "has many reviews" do
      expect(Product.reflect_on_association(:reviews).macro).to eq(:has_many)
    end
  end

  describe "validations" do
    it "validates presence and length of product_title" do
      expect(subject).to validate_presence_of(:product_title)
      expect(subject).to validate_length_of(:product_title).is_at_least(6).is_at_most(30)
    end

    it "validates presence and length of description" do
      expect(subject).to validate_presence_of(:description)
      expect(subject).to validate_length_of(:description).is_at_least(10).is_at_most(3000)
    end

    it "validates presence and uniqueness of sku_id" do
      expect(subject).to validate_presence_of(:sku_id)
      expect(subject).to validate_uniqueness_of(:sku_id)
    end

    it "validates presence of weight" do
      expect(subject).to validate_presence_of(:weight)
    end

    it "validates presence of category_ids" do
      expect(subject).to validate_presence_of(:category_ids)
    end

    it "validates presence of quantity" do
      expect(subject).to validate_presence_of(:quantity)
    end

    it "validates presence and numericality of price" do
      expect(subject).to validate_presence_of(:price)
      expect(subject).to validate_numericality_of(:price).is_greater_than_or_equal_to(1)
    end

    it "validates presence and format of weight_unit" do
      expect(subject).to validate_presence_of(:weight_unit)
    end
  end

  describe "image" do
    it "is attached" do
      expect(subject).to have_one_attached(:image)
    end


    it "adds an error if no image is attached" do
      product = Product.new
      product.valid?
      expect(product.errors[:image]).to include("must be attached")
    end
  end
end
