require 'rails_helper'

RSpec.describe "admin/shops/edit", type: :view do
  before(:each) do
    @shop = assign(:shop, FactoryBot.create(:shop))
  end

  it "renders the edit shop form" do
    render

    assert_select "h1", text: "Edit Shop Profile", count: 1
    assert_select "form[action=?][method=?]", admin_shop_path(@shop), "post" do
      assert_select "div.form-group" do
        assert_select "label[for=?]", "shop_name", text: "Name"
        assert_select "input[name=?][type=?][class=?][required=?]", "shop[name]", "text", "form-control", "required"
      end
      assert_select "div.form-group" do
        assert_select "label[for=?]", "shop_email", text: "Email"
        assert_select "input[name=?][type=?][class=?][required=?]", "shop[email]", "email", "form-control", "required"
      end
      assert_select "div.form-group" do
        assert_select "label[for=?]", "shop_location", text: "Location"
        assert_select "input[name=?][type=?][class=?][required=?]", "shop[location]", "text", "form-control", "required"
      end
      assert_select "div.form-group" do
        assert_select "label[for=?]", "shop_contact_info", text: "Contact info"
        assert_select "input[name=?][type=?][class=?][required=?]", "shop[contact_info]", "text", "form-control", "required"
      end
      assert_select "div.form-group" do
        assert_select "label[for=?]", "shop_password", text: "Password"
        assert_select "input[name=?][type=?][class=?][required=?]", "shop[password]", "password", "form-control", "required"
      end
      assert_select "div.form-group" do
        assert_select "label[for=?]", "shop_password_confirmation", text: "Password confirmation"
        assert_select "input[name=?][type=?][class=?][required=?]", "shop[password_confirmation]", "password", "form-control", "required"
      end
      assert_select "input[name=?][type=?][value=?][class=?]", "commit", "submit", "Update Shop", "btn btn-primary"
    end
  end
end
