require 'rails_helper'

RSpec.describe Admin::ShopsController, type: :controller do
  describe 'GET #index' do
    it 'assigns all shops to @shops' do
      shop1 = create(:shop, name: 'Shop 1', location: 'Location 1', contact_info: 'Contact Info 1', email: 'shop1@example.com')
      shop2 = create(:shop, name: 'Shop 2', location: 'Location 2', contact_info: 'Contact Info 2', email: 'shop2@example.com')
      get :index
    end
  end

    describe 'GET #new' do
      it 'assigns a new shop to @shop' do
        get :new
      end
    end
    describe 'POST #create' do
      context 'with valid parameters' do
        it 'creates a new shop' do
          expect {
            post :create, params: { shop: attributes_for(:shop) }
          }
  
        end
      it 'redirects to the admin shops index page' do
        post :create, params: { shop: attributes_for(:shop) }
      end

      it 'sets a success notice' do
        post :create, params: { shop: attributes_for(:shop) }
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new shop' do
        expect {
          post :create, params: { shop: attributes_for(:shop, name: nil) }
        }.to_not change(Shop, :count)
      end

      it 'renders the new template' do
        post :create, params: { shop: attributes_for(:shop, name: nil) }
      end
    end
  end

  describe 'GET #edit' do
 
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the requested shop' do
        shop = create(:shop)
        patch :update, params: { id: shop.id, shop: { name: 'Shop 3' } }
        shop.reload
      end

      it 'redirects to the admin shops index page' do
        shop = create(:shop)
        patch :update, params: { id: shop.id, shop: { name: 'Shop 3' } }
      end

      it 'sets a success notice' do
        shop = create(:shop)
        patch :update, params: { id: shop.id, shop: { name: 'Shop 3' } }
      end
    end

    context 'with invalid parameters' do
      it 'does not update the requested shop' do
        shop = create(:shop)
        original_name = shop.name
        patch :update, params: { id: shop.id, shop: { name: nil } }
        shop.reload
        expect(shop.name).to eq(original_name)
      end

      it 'renders the edit template' do
        shop = create(:shop)
        patch :update, params: { id: shop.id, shop: { name: nil } }
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested shop' do
      shop = create(:shop)
      expect {
        delete :destroy, params: { id: shop.id }
      }
    end

    it 'redirects to the admin shops index page' do
      shop = create(:shop)
      delete :destroy, params: { id: shop.id }
    end

    it 'sets a success notice' do
      shop = create(:shop)
      delete :destroy, params: { id: shop.id }
    end
  end
end
