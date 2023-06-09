require 'rails_helper'

RSpec.describe "categories/_form.html.erb", type: :view do
  let(:category) { Category.new }

  before do
    assign(:category, category)
    render
  end

  it "renders the form with the correct attributes" do
    expect(rendered).to have_selector("form[action='#{categories_path}'][method='post']")
    expect(rendered).to have_selector("input[name='category[name]'][type='text']")
    expect(rendered).to have_selector("input[type='submit'][value='Create Category']")
  end
end
