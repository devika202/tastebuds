require 'rails_helper'

RSpec.describe "shops/dashboard.html.erb", type: :view do
  let(:current_shop) { FactoryBot.create(:shop) }

  before do
    assign(:shop, current_shop)
    render
  end

  it "displays the welcome message" do
    expect(rendered).to have_content("Welcome to your shop dashboard")
    expect(rendered).to have_content(current_shop.name)
  end

  it "displays the 'Add Sales Report' link" do
    expect(rendered).to have_link("Add Sales Report", href: new_shop_sales_report_path)
  end

  it "displays the 'View Sales Reports' link" do
    expect(rendered).to have_link("View Sales Reports", href: shop_sales_reports_path)
  end

  it "renders the view with the correct structure" do
    expect(rendered).to have_selector(".border.border-dark.p-2.p-3.mb-2.bg-danger-subtle")
    expect(rendered).to have_selector(".shadow-lg.p-3.mb-5.bg-body-tertiary.rounded")
    expect(rendered).to have_selector("h1.text-center.mt-4")
    expect(rendered).to have_selector("div.text-center")
  end
end
