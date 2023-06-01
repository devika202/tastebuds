require 'rails_helper'

RSpec.describe OrderHistoryController, type: :controller do
  describe 'GET index' do
    context 'when user is signed in' do
      let(:user) { create(:user) }
      let!(:order1) { create(:order, user: user) }
      let!(:order2) { create(:order, user: user) }

      before do
        allow(controller).to receive(:current_user).and_return(user)
        get :index
      end

      it 'assigns @orders with current user\'s orders' do
        expect(assigns(:orders)).to eq([order1, order2])
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
