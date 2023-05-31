# require 'rails_helper'

# RSpec.describe Admin::OrdersController, type: :controller do
#   describe 'GET #show' do
#     context 'when user is authenticated' do
#       before { sign_in(create(:user)) }
#       let(:order) { create(:order) }
      
#       it 'assigns the specified order to @order' do
#         get :show, params: { id: order.id }
#         expect(assigns(:order)).to eq(order)
#       end
      
#       it 'renders the show template' do
#         get :show, params: { id: order.id }
#         expect(response).to render_template(:show)
#       end
#     end
    
#     context 'when user is not authenticated' do
#       it 'redirects to the root_url' do
#         get :show, params: { id: 1 }
#         expect(response).to redirect_to(root_url)
#       end
#     end
#   end
  
#   describe 'POST #create' do
#     context 'when user is authenticated' do
#       before { sign_in(create(:user)) }
      
#       it 'creates a new order' do
#         expect {
#           post :create, params: { order: { shipping_name: 'John Doe', shipping_address: '123 Main St' } }
#         }.to change(Order, :count).by(1)
#       end
      
#       it 'redirects to the show template of the created order' do
#         post :create, params: { order: { shipping_name: 'John Doe', shipping_address: '123 Main St' } }
#         expect(response).to redirect_to(admin_order_url(Order.last))
#       end
#     end
    
#     context 'when user is not authenticated' do
#       it 'redirects to the root_url' do
#         post :create
#         expect(response).to redirect_to(root_url)
#       end
#     end
#   end
# end
