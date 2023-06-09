require 'rails_helper'

RSpec.describe "categories/_category", type: :view do
  let(:category) { FactoryBot.create(:category) }

  before(:each) do
    assign(:category, category)
    render
  end

  it "displays the category name with a link" do
    expect(rendered).to have_link(category.name, href: category_path(category))
  end

  it "displays the category name with the correct CSS classes" do
    expect(rendered).to have_css(".badge.badge-pill.badge-info.mr-1", text: category.name)
  end
end
