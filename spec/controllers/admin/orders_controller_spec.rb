require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  describe 'GET index' do
    it 'assigns all orders to @orders' do
      admin = create(:user, admin: true)
      sign_in admin

      order1 = create(:order)
      order2 = create(:order)

      get :index

    end

    it 'renders the index template' do
      admin = create(:user, admin: true)
      sign_in admin

      get :index

    end

    it 'redirects to the root path if user is not an admin' do
      user = create(:user, admin: false)
      sign_in user

      get :index

      expect(response).to have_http_status(:redirect)    
    end
  end

  describe 'GET show' do
    it 'assigns the requested order to @order' do
      admin = create(:user, admin: true)
      sign_in admin

      order = create(:order)

      get :show, params: { id: order.id }

    end

    it 'renders the show template' do
      admin = create(:user, admin: true)
      sign_in admin

      order = create(:order)

      get :show, params: { id: order.id }

    end
  end

  describe 'PATCH update' do
    let(:admin) { create(:user, admin: true) }
    let(:order) { create(:order) }

    before do
      sign_in admin
    end

    it 'assigns the requested order to @order' do
      patch :update, params: { id: order.id, order: { status: 'shipped' } }

    end

    it 'updates the order status' do
      patch :update, params: { id: order.id, order: { status: 'shipped' } }

      order.reload
    end

    it 'redirects to the show page of the updated order' do
      patch :update, params: { id: order.id, order: { status: 'shipped' } }

    end
  end

  describe 'GET edit' do
    it 'assigns the requested order to @order' do
      admin = create(:user, admin: true)
      sign_in admin

      order = create(:order)

      get :edit, params: { id: order.id }

    end

    it 'renders the edit template' do
      admin = create(:user, admin: true)
      sign_in admin

      order = create(:order)

      get :edit, params: { id: order.id }

    end
  end
end
