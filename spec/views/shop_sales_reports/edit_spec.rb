require 'rails_helper'

RSpec.describe 'shop_sales_reports/edit', type: :view do
  before(:each) do
    @sales_report = assign(:sales_report, FactoryBot.create(:sales_report))
    @categories = assign(:categories, FactoryBot.create_list(:category, 2))
  end

  it 'renders the edit sales report form' do
    render

    assert_select 'h1', text: 'Edit Sales Report', count: 1
    assert_select 'form[action=?][method=?]', shop_sales_report_path(@sales_report), 'post' do
      assert_select 'input[name=?]', 'sales_report[product_name]'
      assert_select 'input[name=?]', 'sales_report[price]'
      assert_select 'input[name=?]', 'sales_report[weight]'
      assert_select 'select[name=?]', 'sales_report[weight_unit]'
      assert_select 'input[name=?]', 'sales_report[quantity]'
      assert_select 'input[name=?]', 'sales_report[total_price]'
      assert_select 'input[name=?]', 'sales_report[date_of_purchase]'
      assert_select 'select[name=?]', 'sales_report[category_id]'
      assert_select 'input[type=?][value=?]', 'submit', 'Update'
    end
  end
end
