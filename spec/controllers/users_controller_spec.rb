require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'GET #show' do
    let(:user) { FactoryBot.create(:user) }
  
    context 'when user is logged in and accessing own profile' do
      before { sign_in(user) }
  
      it 'renders the show template' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:found)
      end
    end

    context 'when accessing other user profile' do
      let(:other_user) { create(:user) }

      it 'redirects to root path' do
        get :show, params: { id: other_user.id }
        expect(flash[:alert]).to eq('Access denied. You can only view your own profile or as an admin.')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is an admin' do
      let(:admin_user) { create(:admin_user) }

      it 'renders the show template' do
        get :show, params: { id: admin_user.id }
      end
    end

    context 'when user is not logged in' do
      it 'redirects to root path' do
        get :show, params: { id: user.id }
        expect(flash[:alert]).to eq('Access denied. You can only view your own profile or as an admin.')
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #index' do
    context 'when user is logged in as an admin' do
      let(:admin_user) { create(:admin_user) }

      before { sign_in(admin_user) }

      it 'renders the index template' do
        get :index
      end

      it 'assigns all users to @users' do
        user1 = create(:user)
        user2 = create(:user)
        get :index
        expect(assigns(:users)).to match_array([admin_user, user1, user2])
      end
    end

    context 'when user is not logged in' do
      it 'redirects to root path' do
        get :index
        expect(flash[:alert]).to eq('Only admins can view the users list.')
        expect(response).to redirect_to(root_path)
      end
    end
  end


  

  describe 'DELETE #destroy' do
        let!(:user_to_delete) { create(:user) }

    context 'when user is logged in as an admin' do
        let(:admin_user) { create(:admin_user) }

        before { sign_in(admin_user) }

        it 'deletes the user' do
        expect {
            delete :destroy, params: { id: user_to_delete.id }
        }.to change(User, :count).by(-1)
        end

        it 'redirects to users index' do
        delete :destroy, params: { id: user_to_delete.id }
        expect(response).to have_http_status(:redirect)
        end
    end

    context 'when user is not logged in' do
        it 'redirects to root path' do
        delete :destroy, params: { id: user_to_delete.id }
        expect(response).to have_http_status(:redirect)
    end
    end
  end
end
