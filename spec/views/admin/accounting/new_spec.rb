require 'rails_helper'

RSpec.describe "admin/accounting/new", type: :view do
  before(:each) do
    assign(:accounting_record, Accounting.new)
    assign(:orders, [])
    assign(:sales_reports, [])
  end

  it "renders the form" do
    render

    assert_select "h1.text-center.mt-4", text: "Add Accounting Record"
    assert_select "form[action=?][method=?]", admin_accounting_index_path, "post" do
      assert_select "div#error_explanation", count: 0
      assert_select "div.form-group.row.form-label.justify-content-center.align-items-center" do
        assert_select "label.col-5.col-form-label.text-dark.text-center", text: "Online sale"
        assert_select "div.col-5 select[name=?]", "accounting_record[order_id]", count: 0 
      end
      assert_select "div.form-group.row.form-label.justify-content-center.align-items-center" do
        assert_select "label.col-5.col-form-label.text-dark.text-center", text: "Shop sale"
        assert_select "div.col-5 select[name=?]", "accounting_record[sales_report_id]", count: 0 
      end
      assert_select "div.form-group.row.justify-content-center.form-label" do
        assert_select "input[type=?][value=?]", "submit", "Create Accounting"
      end
    end
  end
end
