require 'rails_helper'

RSpec.describe 'shop_sales_reports/new', type: :view do
  before(:each) do
    assign(:sales_report, SalesReport.new)
    assign(:categories, [])
    render
  end

  it 'renders the form' do
    assert_select 'h1', text: 'Add Sales Report', count: 1
    assert_select 'form[action=?][method=?]', shop_sales_reports_path, 'post' do
      assert_select 'div.form-group.row.form-label' do
        assert_select 'div.col-10 input#sales_report_product_name.form-control.shadow.rounded[type=?][required=?][placeholder=?]', 'text', 'required', 'Enter Product name', count: 1
      end

      assert_select 'div.form-group.row.form-label' do
        assert_select 'div.col-10 input#sales_report_price.form-control.shadow.rounded[type=?][step=?][required=?][placeholder=?]', 'number', '0.01', 'required', 'Enter Product Price', count: 1
      end

      assert_select 'div.form-group.row.form-label' do
        assert_select 'div.col-5 input#sales_report_weight.form-control.shadow.rounded[type=?][placeholder=?]', 'number', 'Weight of Product purchased', count: 1
        assert_select 'div.col-5 select[name="sales_report[weight_unit]"].form-control.shadow.rounded', count: 1
      end

      assert_select 'div.form-group.row.form-label' do
        assert_select 'div.col-10 input#sales_report_quantity.form-control.shadow.rounded[type=?][required=?][placeholder=?]', 'number', 'required', 'No of products purchased', count: 1
      end

      assert_select 'div.form-group.row.form-label' do
        assert_select 'div.col-10 input#sales_report_total_price.form-control.shadow.rounded[type=?][step=?][required=?][placeholder=?]', 'number', '0.01', 'required', 'Total Price', count: 1
      end

      assert_select 'div.form-group.row.form-label' do
        assert_select 'div.col-10 input#sales_report_date_of_purchase.form-control.shadow.rounded[type=?][required=?][max=?]', 'date', 'required', Date.today.to_s, count: 1
      end

      assert_select 'div.form-group.row.form-label' do
        assert_select 'div.col-10 select#sales_report_category_id.form-control.shadow.rounded[required="required"]' do
            assert_select 'option[value=?]', '', text: 'Select a category', count: 1
          end
          
      end

      assert_select 'div.form-group.row.justify-content-center.form-label' do
        assert_select 'input[type=?][value=?].btn.btn-dark.btn-lg.width', 'submit', 'Save', count: 1
      end
    end
  end
end
