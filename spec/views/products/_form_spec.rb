require 'rails_helper'

RSpec.describe 'products/_form', type: :view do
  before(:each) do
    @product = assign(:product, Product.new)
  end

  it 'renders the form' do
    render

    assert_select 'form[action=?][method=?]', products_path, 'post' do
      assert_select 'input[name=?]', 'product[product_title]'
      assert_select 'textarea[name=?]', 'product[description]'
      assert_select 'input[name=?]', 'product[weight]'
      assert_select 'select[name=?]', 'product[weight_unit]'
      assert_select 'input[name=?]', 'product[quantity]'
      assert_select 'input[name=?]', 'product[price]'
      assert_select 'input[name=?]', 'product[sku_id]'
      assert_select 'select[name=?]', 'product[category_ids][]'
      assert_select 'input[name=?]', 'product[image]'
    end
  end
end
