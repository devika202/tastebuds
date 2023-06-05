require 'rails_helper'

RSpec.describe CartsController, type: :controller do
    let(:user) { FactoryBot.create(:user) }        
    let(:product) { FactoryBot.create(:product) }

    describe "POST #create" do
        before do
          sign_in user
        end
    
        context "when user has a cart" do
          let!(:cart) { FactoryBot.create(:cart, user: user) }
    
          it "creates a new cart item and redirects to the cart page" do
            puts product.inspect
    
            expect {
                post :create, params: { cart: { product_id: product.id } }
              }
          end
        end
    
    
        context "when user does not have a cart" do
          it "creates a new cart and redirects to the cart page" do
            expect {
              post :create, params: { cart: { product_id: product.id } }
            }
            new_cart = Cart.last
          end
        end
      end

  describe 'GET #show' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'assigns the user cart and renders the show template' do
        expect(assigns(:cart)).to eq(user.cart)
      end
    end
  end

  describe "PATCH #update" do
    context "when user is authenticated" do
        let(:user) { FactoryBot.create(:user) }
        let(:cart) { FactoryBot.create(:cart, user: user) } 
      
       
        it 'adds the product to the cart and redirects to the cart page' do
          patch :update, params: { id: cart.id, cart: { product_id: product.id } }
          cart.reload 
        end
      end
  end

  describe 'PUT #remove_item' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'removes the item from the cart and redirects to the cart page' do
        cart = create(:cart, user: user)
        cart_item = create(:cart_item, cart: cart, product: product)
        put :remove_item, params: { id: cart_item.id }
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        put :remove_item, params: { id: 1 }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #clear_cart' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'clears all cart items and redirects to the cart page' do
        cart = create(:cart, user: user)
        create_list(:cart_item, 3, cart: cart)
        delete :clear_cart
        expect(user.cart.cart_items.count)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign-in page' do
        delete :clear_cart
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
