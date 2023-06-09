# require 'rails_helper'

# RSpec.describe 'categories/show', type: :view do
#   let(:category) { create(:category) }
#   let(:product) { create(:product, category: category) }

#   before(:each) do
#     assign(:category, category)
#     assign(:products, [product])
#     allow(view).to receive(:user_signed_in?).and_return(true)
#     allow(view).to receive(:current_user).and_return(create(:user, admin: true))
#   end

#   it 'displays the category name' do
#     render
#     expect(rendered).to have_selector('h1', text: category.name)
#   end

#   context 'when user is signed in as admin' do
#     it 'displays the "Edit category name" link' do
#       render
#       expect(rendered).to have_link('Edit category name', href: edit_category_path(category))
#     end
#   end

#   context 'when user is not signed in as admin' do
#     before(:each) do
#       allow(view).to receive(:current_user).and_return(create(:user, admin: false))
#     end

#     it 'does not display the "Edit category name" link' do
#       render
#       expect(rendered).not_to have_link('Edit category name', href: edit_category_path(category))
#     end
#   end

#   it 'displays the "Products" heading' do
#     render
#     expect(rendered).to have_selector('h3', text: 'Products')
#   end

#   it 'displays the pagination section' do
#     render
#     expect(rendered).to have_selector('.flickr_pagination')
#   end

#   it 'displays the products' do
#     render
#     expect(rendered).to have_selector('.card', count: 1)
#   end
# end
