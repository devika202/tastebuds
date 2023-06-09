require 'rails_helper'

RSpec.describe "categories/index", type: :view do
  before(:each) do
    category1 = create(:category, name: "Category 1", created_at: 1.day.ago, updated_at: 1.hour.ago)

    create_list(:product, 2, category: category1)

    assign(:categories, [category1])
    allow(view).to receive_messages(will_paginate: nil)
  end

  it "renders a list of categories" do
    render

    assert_select "h1", text: "CATEGORIES", count: 1
    assert_select ".flickr_pagination.mb-4", count: 2

    assert_select ".container" do
      assert_select ".row.justify-content-center", count: 1

      assert_select ".col-4.mt-4" do
        assert_select ".card.text-center.shadow.mb-5.bg-white.rounded" do
          assert_select ".card-body" do
            assert_select "h5.card-title a.text-success", text: "Category 1", count: 1
            assert_select "p.card-text", text: "2 products", count: 1
            assert_select "a.btn.btn-outline-danger", text: "Delete", count: 1
          end
          assert_select ".card-footer.text-muted" do
            assert_select "small", text: /Created.+ago, edited.+ago/, count: 1
          end
        end
      end
    end

    assert_select ".flickr_pagination.mb-4", count: 2
  end
end
