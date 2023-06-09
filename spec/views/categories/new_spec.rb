require 'rails_helper'

RSpec.describe 'categories/new', type: :view do
  let(:category) { FactoryBot.create(:category) }

  before(:each) do
    @category = assign(:category, category)
    @search = assign(:search, Product.ransack(params[:q]))
  end

  it 'renders the create category form' do
    render

    assert_select 'h1.text-center.mt-4', text: 'Create a new category'
    assert_select 'div.container' do
      assert_select 'div.row.justify-content-center' do
        assert_select 'div.col-10' do
          assert_select 'form[action=?][method=?]', category_path(@category), 'post' do
            assert_select 'input[name=?]', 'category[name]'
          end

          assert_select 'div.form-group.row.justify-content-center.form-label' do
            assert_select "a[href='#{categories_path}'].btn.btn-info.btn-lg[style='width: 500px;']", text: 'Cancel and return to category'
          end
        end
      end
    end
  end
end
