require 'rails_helper'

RSpec.describe "pages/about.html.erb", type: :view do
  before do
    render
  end

  it "displays the heading 'ABOUT US'" do
    expect(rendered).to have_selector("h1", text: "ABOUT US")
  end

  it "displays the subheading 'Explore the taste of nature. Quality is our promise! We are here with the best.'" do
    expect(rendered).to have_selector("h2", text: "Explore the taste of nature. Quality is our promise! We are here with the best.")
  end

  it "displays the description paragraphs" do
    expect(rendered).to have_selector("p", text: "At Tastebuds, we believe that good food brings people together and creates memorable experiences. That's why we are dedicated to providing you with the finest and freshest ingredients sourced directly from local farms and producers.")
    expect(rendered).to have_selector("p", text: "Our team of passionate chefs and food enthusiasts work tirelessly to craft delicious and wholesome dishes that satisfy your cravings and ignite your taste buds. We prioritize flavor, quality, and nutritional value in every product we offer.")
    expect(rendered).to have_selector("p", text: "With our online food ordering platform, you can conveniently explore our wide range of delectable products, carefully categorized for easy browsing. Whether you're craving a hearty meal, a quick snack, or a delightful dessert, we have something for everyone.")
    expect(rendered).to have_selector("p", text: "We understand the importance of food safety and hygiene, which is why we follow strict standards and protocols in our kitchen and production processes. Your health and satisfaction are our top priorities.")
    expect(rendered).to have_selector("p", text: "At Tastebuds, we also value your feedback and strive to continuously improve our offerings. We encourage you to leave product reviews and share your experiences with us. Your input helps us enhance our menu and provide an exceptional culinary experience.")
    expect(rendered).to have_selector("p", text: "Thank you for choosing Tastebuds as your trusted source of delicious and nourishing food. We look forward to serving you and bringing joy to your dining table.")
  end

  it "displays the closing statement 'Discover the taste of Tastebuds today!'" do
    expect(rendered).to have_selector("h3", text: "Discover the taste of Tastebuds today!")
  end
end
