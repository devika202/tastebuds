require 'rails_helper'

RSpec.describe SalesReport, type: :model do
  describe "associations" do
    it { should belong_to(:shop) }
    it { should belong_to(:category) }
    it { should have_one(:accounting).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:date_of_purchase) }
    it { should validate_presence_of(:product_name) }
    it { should validate_presence_of(:category_id) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:total_price) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:weight) }

    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:total_price).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
    it { should validate_numericality_of(:weight).is_greater_than_or_equal_to(1) }

    it { should validate_presence_of(:weight_unit) }
    it { should allow_value("kg").for(:weight_unit) }
    it { should allow_value("lbs").for(:weight_unit) }
    it { should_not allow_value("123").for(:weight_unit) }
    it { should_not allow_value("kg1").for(:weight_unit) }
  end

  describe "#create_accounting" do
    it "creates an accounting record associated with the sales report" do
      sales_report = SalesReport.new
      sales_report.create_accounting
      expect(sales_report.accounting).to be_present
      expect(sales_report.accounting).to be_a(Accounting)
    end
  end
end
