require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it "has one cart" do
      expect(User.reflect_on_association(:cart).macro).to eq(:has_one)
    end

    it "has many orders" do
      expect(User.reflect_on_association(:orders).macro).to eq(:has_many)
    end

    it "has many reviews" do
      expect(User.reflect_on_association(:reviews).macro).to eq(:has_many)
    end
  end

  describe "validations" do
    it "validates presence and length of firstname" do
      expect(subject).to validate_presence_of(:firstname)
      expect(subject).to validate_length_of(:firstname).is_at_least(3).is_at_most(10)
    end

    it "validates presence and length of phone" do
      expect(subject).to validate_numericality_of(:phone)
    end

    it "validates presence and length of address" do
      expect(subject).to validate_presence_of(:address)
      expect(subject).to validate_length_of(:address).is_at_least(10).is_at_most(200)
    end

    it "validates presence and length of lastname" do
      expect(subject).to validate_presence_of(:lastname)
      expect(subject).to validate_length_of(:lastname).is_at_least(1).is_at_most(10)
    end

    it "validates presence and length of username" do
      expect(subject).to validate_presence_of(:username)
      expect(subject).to validate_length_of(:username).is_at_least(3).is_at_most(10)
    end
  end


  describe "#admin?" do
    it "returns true when user is an admin" do
      user = User.new(admin: true)
      expect(user.admin?).to be true
    end

    it "returns false when user is not an admin" do
      user = User.new(admin: false)
      expect(user.admin?).to be false
    end
  end
end
