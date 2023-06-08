require 'rails_helper'

RSpec.describe 'shop_sales_reports/admin_index', type: :view do
  let(:sales_reports) { create_list(:sales_report, 3) }
  let(:search) { SalesReport.ransack }

  before do
    assign(:search, search)
    assign(:sales_reports, sales_reports)
    render
  end

  it 'displays the page title' do
    expect(rendered).to have_selector('h1', text: 'All Sales Reports')
  end

  it 'displays the search form' do
    expect(rendered).to have_selector('form[action="/admin/sales_reports"][method="get"]')
end

  it 'displays the table headers' do
    expect(rendered).to have_selector('th', text: 'Shop Name')
    expect(rendered).to have_selector('th', text: 'Product Name')
    expect(rendered).to have_selector('th', text: 'Price')
    expect(rendered).to have_selector('th', text: 'Weight')
    expect(rendered).to have_selector('th', text: 'Quantity')
    expect(rendered).to have_selector('th', text: 'Total Price')
    expect(rendered).to have_selector('th', text: 'Date of Purchase')
    expect(rendered).to have_selector('th', text: 'Category')
  end

  it 'displays the sales reports data' do
    sales_reports.each do |report|
      expect(rendered).to have_selector('td', text: report.shop.name)
      expect(rendered).to have_selector('td', text: report.product_name)
      expect(rendered).to have_selector('td', text: report.price.to_s)
      expect(rendered).to have_selector('td', text: "#{report.weight} #{report.weight_unit}")
      expect(rendered).to have_selector('td', text: report.quantity.to_s)
      expect(rendered).to have_selector('td', text: report.total_price.to_s)
      expect(rendered).to have_selector('td', text: report.date_of_purchase.to_s)
      expect(rendered).to have_selector('td', text: report.category.name)
    end
  end
end
