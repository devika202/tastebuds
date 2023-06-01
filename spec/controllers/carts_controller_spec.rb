# require 'rails_helper'

# RSpec.describe CartsController, type: :controller do
#     let(:user) { create(:user) }
#     let(:cart) { create(:cart, user: user) }
#     let(:product) { create(:product) }
  
#     describe 'POST #create' do
#       context 'when user is authenticated' do
#         before { sign_in user }
  
#         context 'when the cart is empty' do
#           it 'creates a new cart for the user and adds the product to it' do
#             expect {
#               post :create, params: { cart: { product_id: product.id } }
#             }.to change { Cart.count }.by(1)
  
#             expect(user.cart.cart_items.count).to eq(1)
#             expect(response).to redirect_to(cart_path(user.cart))
#             expect(flash[:notice]).to eq('Product was successfully added to cart.')
#           end
#         end
  
#         context 'when the cart already exists' do
#           let!(:existing_cart) { create(:cart, user: user) }
  
#           it 'adds the product to the existing cart' do
#             expect {
#               post :create, params: { cart: { product_id: product.id } }
#             }.not_to change { Cart.count }
  
#             expect(user.cart.cart_items.count).to eq(1)
#             expect(response).to redirect_to(cart_path(user.cart))
#             expect(flash[:notice]).to eq('Product was successfully added to cart.')
#           end
#         end
  
#         context 'when unable to add product to cart' do
#           it 'redirects to the root path with an alert' do
#             allow_any_instance_of(Cart).to receive(:save).and_return(false)
  
#             post :create, params: { cart: { product_id: product.id } }
  
#             expect(response).to redirect_to(root_path)
#             expect(flash[:alert]).to eq('Unable to add product to cart.')
#           end
#         end
#       end
  
#       context 'when user is not authenticated' do
#         it 'redirects to the sign-in page' do
#           post :create, params: { cart: { product_id: product.id } }
  
#           expect(response).to redirect_to(new_user_session_path)
#         end
#       end
#     end
  
#     describe 'GET #show' do
#       context 'when user is authenticated' do
#         before { sign_in user }
  
#         it 'assigns the user\'s cart to @cart and renders the show template' do
#           get :show
  
#           expect(assigns(:cart)).to eq(user.cart)
#           expect(response).to render_template(:show)
#         end
#       end
  
#       context 'when user is not authenticated' do
#         it 'redirects to the sign-in page' do
#           get :show
  
#           expect(response).to redirect_to(new_user_session_path)
#         end
#       end
#     end
  
#     describe 'PUT #update' do
#       context 'when user is authenticated' do
#         before { sign_in user }
  
#         it 'adds the product to the cart and redirects to the cart page' do
#           put :update, params: { cart: { product_id: product.id } }
  
#           expect(user.cart.cart_items.count).to eq(1)
#           expect(response).to redirect_to(cart_path(user.cart))
#         end
#       end
  
#       context 'when user is not authenticated' do
#         it 'redirects to the sign-in page' do
#           put :update, params: { cart: { product_id: product.id } }
  
#           expect(response).to redirect_to(new_user_session_path)
#         end
#       end
#     end
  
#     describe 'POST #add_item' do
#       context 'when user is authenticated' do
#         before { sign_in user }
  
#         it 'creates a new cart if the user does not have one, adds the product, and redirects to the product page' do
#           post :add_item, params: { product_id: product.id }
  
#           expect(user.cart.cart_items.count).to eq(1)
#           expect(response).to redirect_to(product_path(product))
#           expect(flash[:notice]).to eq('Product added to cart')
#         end
#       end
  
#       context 'when user is not authenticated' do
#         it 'redirects to the sign-in page' do
#           post :add_item, params: { product_id: product.id }
  
#           expect(response).to redirect_to(new_user_session_path)
#         end
#       end
#     end
  
#     describe 'PUT #remove_item' do
#       context 'when user is authenticated' do
#         before { sign_in user }
  
#         it 'removes the item from the cart and redirects to the cart page' do
#           cart_item = create(:cart_item, cart: cart)
  
#           put :remove_item, params: { id: cart_item.id }
  
#           expect(user.cart.cart_items.count).to eq(0)
#           expect(response).to redirect_to(cart_path)
#         end
#       end
  
#       context 'when user is not authenticated' do
#         it 'redirects to the sign-in page' do
#           put :remove_item, params: { id: 1 }
  
#           expect(response).to redirect_to(new_user_session_path)
#         end
#       end
#     end
  
#     describe 'DELETE #clear_cart' do
#       context 'when user is authenticated' do
#         before { sign_in user }
  
#         it 'clears all cart items and redirects to the cart page' do
#           create_list(:cart_item, 3, cart: cart)
  
#           delete :clear_cart
  
#           expect(user.cart.cart_items.count).to eq(0)
#           expect(response).to redirect_to(cart_path(user.cart))
#         end
#       end
  
#       context 'when user is not authenticated' do
#         it 'redirects to the sign-in page' do
#           delete :clear_cart
  
#           expect(response).to redirect_to(new_user_session_path)
#         end
#       end
#     end
#   end
  