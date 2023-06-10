require 'rails_helper'

RSpec.describe 'categories/show', type: :view do
  let(:category) { create(:category) }
  let(:product1) { create(:product, category: category) }
  let(:product2) { create(:product, category: category) }
  let(:products) { [product1, product2] }

  before do
    assign(:category, category)
    assign(:products, products)
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(create(:user, admin: true))
    allow(view).to receive(:will_paginate)
    render
  end

  it 'displays the category name' do
    expect(rendered).to have_css('h1.text-center', text: category.name)
  end

  context 'when user is signed in as an admin' do
    it 'displays the "Edit category name" link' do
      expect(rendered).to have_link('Edit category name', href: edit_category_path(category), class: 'btn btn-info')
    end
  end

  it 'displays the "Products" heading' do
    expect(rendered).to have_css('h3.text-center', text: 'Products')
  end

  it 'displays the products' do
    expect(rendered).to have_selector('.card', count: products.size)
  end

  it 'displays the pagination links' do
    expect(view).to have_received(:will_paginate).twice
  end
end
