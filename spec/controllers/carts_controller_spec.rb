# require 'rails_helper'

# RSpec.describe CartsController, type: :controller do
#     let(:user) { FactoryBot.create(:user) }        
#     let(:product) { FactoryBot.create(:product) }

#     describe "POST #create" do
#         before do
#           sign_in user
#         end
    
#         context "when user has a cart" do
#           let!(:cart) { FactoryBot.create(:cart, user: user) }
    
#           it "creates a new cart item and redirects to the cart page" do
#             puts product.inspect # Debugging statement
    
#             expect {
#                 post :create, params: { cart: { product_id: product.id } }
#               }.to change(CartItem, :count).by(1)
    
#             expect(response).to redirect_to(cart_path(cart))
#             expect(flash[:notice]).to eq("Product was successfully added to cart.")
#           end
#         end
    
    
#         context "when user does not have a cart" do
#           it "creates a new cart and redirects to the cart page" do
#             expect {
#               post :create, params: { cart: { product_id: product.id } }
#             }.to change(Cart, :count).by(1)
#              .and change(CartItem, :count).by(1)
    
#             new_cart = Cart.last
#             expect(response).to redirect_to(cart_path(new_cart))
#             expect(flash[:notice]).to eq("Product was successfully added to cart.")
#           end
#         end
#       end

#   describe 'GET #show' do
#     context 'when user is authenticated' do
#       before { sign_in user }

#       it 'assigns the user cart and renders the show template' do
#         get :show
#         expect(assigns(:cart)).to eq(user.cart)
#         expect(response).to render_template(:show)
#       end
#     end

#     context 'when user is not authenticated' do
#       it 'redirects to the sign-in page' do
#         get :show
#         expect(response).to redirect_to(new_user_session_path)
#       end
#     end
#   end

#   describe "PATCH #update" do
#     context "when user is authenticated" do
#         let(:user) { FactoryBot.create(:user) }
#         let!(:cart) { FactoryBot.create(:cart, user: user) } # Use let! to create the cart before the test
      
       
#         it 'adds the product to the cart and redirects to the cart page' do
#           patch :update, params: { id: cart.id, cart: { product_id: product.id } }
#           cart.reload # Refresh the cart instance from the database
#           expect(assigns(:cart)).to eq(cart)
#           expect(response).to redirect_to(cart_path(cart))
#         end
#       end
      
      
#     context 'when user is not authenticated' do
#       it 'redirects to the sign-in page' do
#         patch :update, params: { cart: { product_id: product.id } }
#         expect(response).to redirect_to(new_user_session_path)
#       end
#     end
#   end

#   describe 'PUT #remove_item' do
#     context 'when user is authenticated' do
#       before { sign_in user }

#       it 'removes the item from the cart and redirects to the cart page' do
#         cart = create(:cart, user: user)
#         cart_item = create(:cart_item, cart: cart, product: product)
#         put :remove_item, params: { id: cart_item.id }
#         expect(assigns(:cart)).to eq(user.cart)
#         expect(response).to redirect_to(cart_path(user.cart))
#       end
#     end

#     context 'when user is not authenticated' do
#       it 'redirects to the sign-in page' do
#         put :remove_item, params: { id: 1 }
#         expect(response).to redirect_to(new_user_session_path)
#       end
#     end
#   end

#   describe 'DELETE #clear_cart' do
#     context 'when user is authenticated' do
#       before { sign_in user }

#       it 'clears all cart items and redirects to the cart page' do
#         cart = create(:cart, user: user)
#         create_list(:cart_item, 3, cart: cart)
#         delete :clear_cart
#         expect(assigns(:cart)).to eq(user.cart)
#         expect(user.cart.cart_items.count).to eq(0)
#         expect(response).to redirect_to(cart_path(user.cart))
#       end
#     end

#     context 'when user is not authenticated' do
#       it 'redirects to the sign-in page' do
#         delete :clear_cart
#         expect(response).to redirect_to(new_user_session_path)
#       end
#     end
#   end
# end
