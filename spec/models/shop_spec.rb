require 'rails_helper'

RSpec.describe Shop, type: :model do
  describe "associations" do
    it "has many sales_reports" do
      expect(Shop.reflect_on_association(:sales_reports).macro).to eq(:has_many)
    end
  end

  describe "validations" do
    it "validates presence and length of name" do
      expect(subject).to validate_presence_of(:name)
      expect(subject).to validate_length_of(:name).is_at_least(6).is_at_most(30)
    end

    it "validates presence and length of location" do
      expect(subject).to validate_presence_of(:location)
      expect(subject).to validate_length_of(:location).is_at_least(6).is_at_most(300)
    end

    it "validates presence and length of contact_info" do
      expect(subject).to validate_presence_of(:contact_info)
      expect(subject).to validate_length_of(:contact_info).is_at_least(6).is_at_most(300)
    end

    it "validates uniqueness and presence of email" do
      expect(subject).to validate_presence_of(:email)
      expect(subject).to validate_uniqueness_of(:email).case_insensitive
    end

    it "validates email format" do
      expect(subject).to allow_value('test@example.com').for(:email)
      expect(subject).not_to allow_value('invalid_email').for(:email)
    end

    it "validates presence of password" do
      expect(subject).to validate_presence_of(:password)
    end

    it "validates presence of password_confirmation" do
      expect(subject).to validate_presence_of(:password_confirmation)
    end
  end
end
