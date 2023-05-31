require 'rails_helper'

RSpec.describe ShopsController, type: :controller do
  before { Shop.destroy_all }

  describe '#dashboard' do
    context 'when logged in' do
      let(:shop) { create(:shop) }

      before do
        allow(controller).to receive(:current_shop).and_return(shop)
        get :dashboard
      end

      it 'assigns @shop with current shop' do
        expect(assigns(:shop)).to eq(shop)
      end

      it 'renders the dashboard template' do
        expect(response).to render_template(:dashboard)
      end
    end

    context 'when not logged in' do
      before { get :dashboard }

      it 'redirects to the login page' do
        expect(response).to redirect_to('/shops/login')
      end
    end
  end

  describe '#index' do
    let!(:shops) { create_list(:shop, 3) }
  
    before { get :index }
  
    it 'assigns @shops with all shops' do
      expect(assigns(:shops)).to match_array(shops)
    end
  
    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end
  
  

  describe '#login' do
    let!(:shop) { create(:shop, email: 'test@example.com', password: 'password') }

    context 'with valid credentials' do
      before do
        post :login, params: { email: 'test@example.com', password: 'password' }
      end

      it 'sets the shop id in the session' do
        expect(session[:shop_id]).to eq(shop.id)
      end

      it 'redirects to the root path' do
        expect(response).to redirect_to(root_path)
      end

      it 'sets a success flash notice' do
        expect(flash[:notice]).to eq('Logged in successfully!')
      end
    end

    context 'with invalid credentials' do
      before do
        post :login, params: { email: 'test@example.com', password: 'wrong_password' }
      end

      it 'renders the login template' do
        expect(response).to render_template(:login)
      end

      it 'sets an error flash message' do
        expect(flash[:error]).to eq('Invalid email or password')
      end
    end
  end

  describe '#logout' do
    before do
      session[:shop_id] = nil
      get :logout
    end

    it 'clears the shop id from the session' do
      expect(session[:shop_id]).to be_nil
    end

    it 'redirects to the root path' do
       expect(response).to have_http_status(:redirect)    
    end
  end
end
