require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "associations" do
    it "belongs to a product" do
      expect(Review.reflect_on_association(:product).macro).to eq(:belongs_to)
    end

    it "belongs to a user" do
      expect(Review.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
  end
end
