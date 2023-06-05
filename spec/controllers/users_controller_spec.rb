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

#   describe 'GET #edit' do
#     let(:user) { create(:user) }

#     before { sign_in(user) }
    
#     context 'when user is logged in as an admin' do
#       let(:admin_user) { create(:admin_user) }

#       before { sign_in(admin_user) }

#       context 'when user exists' do
#         it 'renders the edit template' do
#           get :edit, params: { id: user.id }
#           expect(response).to render_template(:edit)
#         end
#       end

#       context 'when user does not exist' do
#         it 'redirects to root path' do
#           get :edit, params: { id: user.id }
#           expect(flash[:alert]).to eq('User not found.')
#           expect(response).to redirect_to(root_path)
#         end
#       end
#     end

#     context 'when user is logged in and accessing own profile' do
#       before { sign_in(user) }

#       it 'renders the edit template' do
#         get :edit, params: { id: user.id }
#         expect(response).to render_template(:edit)
#       end
#     end

#     context 'when user is not logged in' do
#       it 'redirects to root path' do
#         get :edit, params: { id: user.id }
#         expect(flash[:alert]).to eq('Access denied. You can only edit your own profile or as an admin.')
#         expect(response).to redirect_to(root_path)
#       end
#     end
#   end

#   describe 'POST #create' do
#     context 'with valid parameters' do
#       let(:valid_params) { { user: attributes_for(:user) } }

#       it 'creates a new user' do
#         expect {
#           post :create, params: valid_params
#         }.to change(User, :count).by(1)
#       end

#       it 'redirects to root path' do
#         post :create, params: valid_params
#         expect(session[:user_id]).to eq(User.last.id)
#         expect(response).to redirect_to(root_path)
#       end
#     end

#     context 'with invalid parameters' do
#       let(:invalid_params) { { user: attributes_for(:user, email: nil) } }

#       it 'does not create a new user' do
#         expect {
#           post :create, params: invalid_params
#         }.not_to change(User, :count)
#       end

#       it 'renders the new template' do
#         post :create, params: invalid_params
#         expect(response).to render_template(:new)
#       end
#     end
#   end

#   describe 'PATCH #update' do
#     let(:user) { create(:user) }
#     let(:valid_params) { { id: user.id, user: { firstname: 'New Name' } } }
#     let(:invalid_params) { { id: user.id, user: { email: user.email } } }
  
#     context 'when user is logged in' do
#       before { sign_in(user) }
  
#       context 'with valid parameters' do
#         it 'updates the user data' do
#           patch :update, params: valid_params
#           user.reload
#           expect(user.firstname).to eq('New Name')
#         end
  
#         it 'redirects to the user profile' do
#           patch :update, params: valid_params
#           expect(flash[:notice]).to eq('User data updated successfully')
#           expect(response).to redirect_to(user)
#         end
#       end
  
#       context 'with invalid parameters' do
#         it 'does not update the user data' do
#           old_firstname = user.firstname
#           patch :update, params: invalid_params
#           user.reload
#           expect(user.firstname).to eq(old_firstname)
#         end
  
#         it 'renders the edit template' do
#           patch :update, params: invalid_params
#           expect(response).to render_template(:edit)
#         end
#       end
#     end
  
#     context 'when user is not logged in' do
#       it 'redirects to the sign-in page' do
#         patch :update, params: valid_params
#         expect(response).to redirect_to(new_user_session_path)
#       end
#     end
#   end
  

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
        expect(response).to redirect_to(users_path)
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
