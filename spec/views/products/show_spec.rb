require 'rails_helper'

RSpec.describe 'products/show', type: :view do
  before(:each) do
    @product = assign(:product, FactoryBot.create(:product))
    @review = Review.new(product: @product)
    @cart = assign(:cart, FactoryBot.build(:cart)) # Add this line
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(FactoryBot.build(:user))
    allow(view).to receive(:time_ago_in_words).and_return('2 days ago')
    allow(view).to receive(:form_authenticity_token).and_return('token')
  end
  
  it 'renders the product details' do
    render

    expect(rendered).to have_content(@product.product_title)
    expect(rendered).to have_content(@product.description)
    expect(rendered).to have_content("#{@product.weight} #{@product.weight_unit}")
    expect(rendered).to have_content(@product.sku_id)
    expect(rendered).to have_content(@product.price)

    @product.categories.each do |category|
      expect(rendered).to have_content(category.name)
    end
  end

  context 'when user is signed in' do
    before(:each) do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(FactoryBot.build(:user))
    end

    it 'displays quantity for admin user' do
      allow(view).to receive(:current_user).and_return(FactoryBot.build(:user, admin: true))
      render

      expect(rendered).to have_content(@product.quantity)
    end

    it 'displays availability for regular user when quantity is greater than 0' do
      allow(view).to receive(:current_user).and_return(FactoryBot.build(:user, admin: false))
      allow(@product).to receive(:quantity).and_return(1)
      render

      expect(rendered).to have_content('Product Available')
      expect(rendered).to have_button('Add to Cart')
    end

    it 'displays availability for regular user when quantity is 0' do
      allow(view).to receive(:current_user).and_return(FactoryBot.build(:user, admin: false))
      allow(@product).to receive(:quantity).and_return(0)
      render

      expect(rendered).to have_content('Product Unavailable')
      expect(rendered).not_to have_button('Add to Cart')
    end
  end

  context 'when user is not signed in' do
    before(:each) do
      allow(view).to receive(:user_signed_in?).and_return(false)
    end

    it 'displays login link for adding to cart' do
      render

      expect(rendered).to have_link('Login to Add to Cart', href: new_user_session_path)
    end
  end

  it 'renders the back link' do
    render

    expect(rendered).to have_link('Back', href: products_path)
  end

  it 'renders the reviews section' do
    render

    expect(rendered).to have_selector('.chatbox')
    expect(rendered).to have_selector('.ui.feed')
    expect(rendered).to have_selector('.event', count: @product.reviews.count)
    expect(rendered).to have_selector('.user', count: @product.reviews.count)
    expect(rendered).to have_selector('form.ui.reply.form')
  end
end
