require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  let(:product) { FactoryBot.create(:product) }

  before do
    assign(:product, product)
    render
  end

  it "displays the page title" do
    expect(rendered).to have_selector("h1", text: "Edit Products")
  end

  it "renders the form partial" do
    expect(view).to render_template(partial: "_form")
  end
end
