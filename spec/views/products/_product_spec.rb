require 'rails_helper'

RSpec.describe "products/_product.html.erb", type: :view do
  let(:product1) { FactoryBot.create(:product) }
  let(:product2) { FactoryBot.create(:product) }
  let(:product3) { FactoryBot.create(:product) }
  let(:products) { [product1, product2, product3] }

  before do
    assign(:products, products)
    render
  end

  it "displays the products" do
    expect(rendered).to have_selector('.row.new1', count: 1)
    expect(rendered).to have_selector('.col-md-4', count: 3)

    products.each do |product|
      expect(rendered).to have_selector(".card[data-product-id='#{product.id}']")
      expect(rendered).to have_link(product.product_title, href: product_path(product))
      expect(rendered).to have_selector(".card-text:contains('#{product.weight} #{product.weight_unit}')")
      expect(rendered).to have_link(product.price, href: product_path(product.id))
      expect(rendered).to have_selector(".text-success.card-title.text-center:contains('Product Available')")
      expect(rendered).to have_link("View", href: product_path(product.id))
    end
  end

  it "displays product categories" do
    products.each do |product|
      categories_text = product.categories.map(&:name).join(', ')
      expect(rendered).to have_selector(".card[data-product-id='#{product.id}'] .card-text:contains('#{categories_text}')")
    end
  end
end
