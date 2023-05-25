require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  describe "associations" do
    it "belongs to a product" do
      expect(ProductCategory.reflect_on_association(:product).macro).to eq(:belongs_to)
    end

    it "belongs to a category" do
      expect(ProductCategory.reflect_on_association(:category).macro).to eq(:belongs_to)
    end
  end
end
