require 'rails_helper'

RSpec.describe "shop_sales_reports/index", type: :view do
  let(:current_shop) { create(:shop) }
  let(:sales_reports) { create_list(:sales_report, 3, shop: current_shop) }

  before(:each) do
    assign(:sales_reports, sales_reports)
    assign(:shop, current_shop)

    render
  end

  it "displays the sales reports" do
    sales_reports.each do |sales_report|
      assert_select "td", text: sales_report.product_name.to_s
      assert_select "td", text: sales_report.price.to_s
      assert_select "td", text: "#{sales_report.weight} #{sales_report.weight_unit}"
      assert_select "td", text: sales_report.quantity.to_s
      assert_select "td", text: sales_report.total_price.to_s
      assert_select "td", text: sales_report.date_of_purchase.to_s
      assert_select "td", text: sales_report.category.name.to_s
    end
  end
  
  it "displays a message when no sales reports are found" do
    assign(:sales_reports, [])
    render
    assert_select "p", text: "No sales reports found."
  end

  it "displays the 'Add Sales Report' button" do
    assert_select "a.btn.btn-primary[href=?]", new_shop_sales_report_path, text: "Add Sales Report"
  end
end
