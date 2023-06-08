require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  describe "GET #new" do
    context "when the cart is not empty" do
      let(:user) { create(:user) }
      let(:cart) { create(:cart, user: user) }
      let(:product) { create(:product) }
      let!(:cart_item) { create(:cart_item, cart: cart, product: product) }
      
      before do
        allow(controller).to receive(:current_user).and_return(user)
      end
      
      it "assigns a new order" do
        get :new
        expect(assigns(:order)).to be_a_new(Order)
      end
      
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
    
    context "when the cart is empty" do
      let(:user) { create(:user) }
      let(:cart) { create(:cart, user: user) }
      
      before do
        allow(controller).to receive(:current_user).and_return(user)
        allow(user).to receive_message_chain(:cart, :cart_items, :empty?).and_return(true)
      end
      
      it "sets a flash notice" do
        get :new
        expect(flash[:notice]).to eq("Your cart is empty. Please add some products to proceed to checkout.")
      end
      
      it "redirects to the products index page" do
        get :new
        expect(response).to redirect_to(products_path)
      end
    end
  end
  
  describe "POST #create" do
    let(:user) { create(:user) }
    let(:cart) { create(:cart, user: user) }
    let(:product) { create(:product, quantity: 10) }
    let(:order_params) do
      {
        order: {
          shipping_name: "Devika",
          shipping_address: "Kollam, kerala",
          shipping_city: "City",
          shipping_state: "State",
          shipping_zipcode: "12345",
          payment_method: "Credit Card"
        }
      }
    end
    
    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:order_params).and_return(order_params[:order])
    end
    
    context "when order_params are present" do
    #   context "when the order is successfully created" do
    #     before do
    #       allow(Order).to receive(:new).and_return(order)
    #       allow(order).to receive(:save).and_return(true)
    #     end
        
    #     let(:order) { build(:order) }
        
    #     context "when all products have sufficient quantity" do
    #       let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 5) }
          
    #       it "builds a new order associated with the current user" do
    #         expect(user.orders).to receive(:build).with(order_params[:order]).and_return(order)
    #         post :create
    #       end
          
    #       it "sets the order status to 'pending'" do
    #         post :create
    #         expect(order.status).to eq("pending")
    #       end
          
    #       it "updates the product quantity and creates order items" do
    #         expect(product).to receive(:update).with(quantity: 5)
    #         expect(order.order_items).to receive(:create).with(product: product, quantity: 5)
    #         post :create
    #       end
          
    #       it "clears the user's cart" do
    #         expect(cart).to receive(:clear_cart)
    #         post :create
    #       end
          
    #       it "redirects to the order confirmation page" do
    #         post :create
    #         expect(response).to redirect_to(order_confirmation_path(order))
    #       end
    #     end
        
    #     context "when one or more products have insufficient quantity" do
    #       let!(:cart_item1) { create(:cart_item, cart: cart, product: product, quantity: 10) }
    #       let!(:cart_item2) { create(:cart_item, cart: cart, product: product, quantity: 6) }
          
    #       before do
    #         allow(product).to receive(:update).and_return(false)
    #       end
          
    #       it "does not create an order" do
    #         expect(user.orders).not_to receive(:build)
    #         post :create
    #       end
          
    #       it "sets a flash notice with the product errors" do
    #         post :create
    #         expect(flash[:notice]).to include("Insufficient quantity for product: #{product.product_title}. Available quantity: #{product.quantity}")
    #       end
          
    #       it "redirects to the products index page" do
    #         post :create
    #         expect(response).to redirect_to(products_path)
    #       end
    #     end
    #   end
      
      context "when the order fails to save" do
        let(:order) { build(:order) }
        
        before do
          allow(Order).to receive(:new).and_return(order)
          allow(order).to receive(:save).and_return(false)
        end
        
        it 'does not create an order' do
            expect {
              post :create, params: order_params
            }.not_to change(Order, :count)
          end
        
        it "sets a flash notice with the order errors" do
          post :create
          expect(flash[:notice]).to eq(order.errors.full_messages.join(", "))
        end
        
        it "renders the new template" do
          post :create
          expect(response).to render_template(:new)
        end
      end
    end
    
    context "when order_params are not present" do
      before do
        allow(controller).to receive(:order_params).and_return(nil)
      end
      
      it "sets a flash notice" do
        post :create
        expect(flash[:notice]).to eq("Please fill in your shipment details to proceed to checkout.")
      end
      
      it "renders the new template" do
        post :create
        expect(response).to render_template(:new)
      end
    end
  end
end