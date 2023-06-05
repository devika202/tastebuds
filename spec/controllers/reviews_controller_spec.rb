require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
    render_views
  describe 'POST #create' do
    let(:product) { create(:product) }
    let(:valid_attributes) { { product_id: product.id, review: { content: 'Great product!' } } }
    let(:user) { FactoryBot.create(:user) }
    context 'when user is authenticated' do
      before { sign_in user }

      it 'creates a new review' do
        expect {
          post :create, params: valid_attributes
        }
      end
      
      it 'assigns the review to the current user' do
        post :create, params: valid_attributes
      end

      it 'redirects to the sign-in page' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is not authenticated' do
      let(:valid_attributes) { { review: { content: 'Great product!' }, product_id: product.id } }

      it 'does not create a new review' do
        expect {
          post :create, params: valid_attributes
        }
      end
      

      it 'redirects to the product page' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(product)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:product) { create(:product) }
    let!(:review) { create(:review, product: product) }
  
    context 'when admin is authenticated' do
        let(:admin_user) { create(:admin_user) }
      
        before do
          sign_in admin_user
          delete :destroy, params: { product_id: product.id, id: review.id }
        end
      
        it 'deletes the review' do
          expect {
            delete :destroy, params: { product_id: product.id, id: review.id }
          }
        end
      
        it 'redirects back to the previous location' do
          expect(response).to have_http_status(:redirect)    
        end
      end
      
      
  
    context 'when admin is not authenticated' do
      let(:user) { create(:user) }
  
      before { sign_in user }
  
      it 'does not delete the review' do
        expect {
          delete :destroy, params: { product_id: product.id, id: review.id }
        }.not_to change(Review, :count)
      end
  
      it 'redirects back to the sign-in page' do
        delete :destroy, params: { product_id: product.id, id: review.id }
        expect(response).to redirect_to(new_user_session_path)
      end
      
      it 'sets flash alert message' do
        delete :destroy, params: { product_id: product.id, id: review.id }
        expect(flash[:alert]).to eq("You have to confirm your email address before continuing.")
      end
      
    end
  end
  
end
