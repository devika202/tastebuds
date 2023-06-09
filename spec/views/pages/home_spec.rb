require 'rails_helper'

RSpec.describe "pages/home.html.erb", type: :view do
  include Devise::Test::ControllerHelpers
  let(:current_shop) { FactoryBot.create(:shop) }
  before do
    assign(:search, Product.ransack(params[:q]))
    assign(:shop, current_shop)
    render
  end

  it "displays the welcome message" do
    expect(rendered).to have_selector("h1", text: "Welcome to Taste Buds")
  end

  it "displays the description" do
    expected_text = "Explore the taste of nature Quality is our promise !!! we are there with the best"
    expect(rendered).to have_selector("p.lead", text: expected_text)
  end
  

  context "when user is an admin" do
    before do
      allow(view).to receive(:current_user).and_return(double(admin?: true))
      render
    end

    it "displays the 'ABOUT' link" do
      expect(rendered).to have_link("ABOUT", href: about_path, class: "btn btn-info btn-lg text-dark")
    end
  end

  context "when user is not signed in" do
    before do
      render
    end

    it "displays the 'LOGIN' link" do
      expect(rendered).to have_link("LOGIN", href: new_user_session_path, class: "btn btn-info btn-lg text-dark")
    end

    it "displays the 'SIGN UP' link" do
      expect(rendered).to have_link("SIGN UP", href: new_user_registration_path, class: "btn btn-info btn-lg text-dark")
    end

    it "displays the 'SHOP LOGIN' link" do
      expect(rendered).to have_link("SHOP LOGIN", href: '/shops/login', class: "btn btn-info btn-lg text-dark")
    end
  end
end
