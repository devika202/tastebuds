require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  describe 'GET #show' do
    context 'when user is authenticated' do
      before { sign_in(create(:user)) }
      let(:order) { create(:order) }
      
      it 'assigns the specified order to @order' do
        get :show, params: { id: order.id }
      end
      
      it 'renders the show template' do
        get :show, params: { id: order.id }
      end
    end
  end
  
  describe 'POST #create' do
    context 'when user is authenticated' do
      before { sign_in(create(:user)) }
      
      it 'creates a new order' do
        expect {
          post :create, params: { order: { shipping_name: ' Devika', shipping_address: '123 Main St' } }
        }
      end
      
      it 'redirects to the show template of the created order' do
        expect {
            post :create, params: { order: { shipping_name: 'Devika', shipping_address: '123 Main St' } }
          }
      end
    end
    
    context 'when user is not authenticated' do
      it 'redirects to the root_url' do
        expect {
            post :create, params: { order: { shipping_name: 'Devika', shipping_address: '123 Main St' } }
          }
        end
    end
  end
end
