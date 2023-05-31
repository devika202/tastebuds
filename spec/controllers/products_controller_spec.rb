require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #show' do
    let(:product) { FactoryBot.create(:product) }

    it 'assigns the requested product to @product' do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end

    it 'assigns a new review to @review' do
      get :show, params: { id: product.id }
      expect(assigns(:review)).to be_a_new(Review)
    end

    context 'when a user is signed in' do
      let(:user) { FactoryBot.create(:user) }

      before { sign_in user }

      it 'assigns the current user\'s cart to @cart' do
        get :show, params: { id: product.id }
        expect(assigns(:cart)).to eq(user.cart)
      end
    end

    context 'when no user is signed in' do
      it 'assigns a new cart to @cart' do
        get :show, params: { id: product.id }
        expect(assigns(:cart)).to be_a_new(Cart)
      end
    end

    context 'when product quantity is zero' do
      before { product.update(quantity: 0) }

      it 'sets the availability message to "Product Unavailable"' do
        get :show, params: { id: product.id }
        expect(assigns(:availability_message)).to eq('Product Unavailable')
      end
    end

    context 'when product quantity is greater than zero' do
      before { product.update(quantity: 5) }

      it 'sets the availability message to "Product Available"' do
        get :show, params: { id: product.id }
        expect(assigns(:availability_message)).to eq('Product Available')
      end
    end
  end

  describe 'GET #index' do
    let(:products) { FactoryBot.create_list(:product, 10)  }
  
    # it 'assigns all products to @products' do
    #   get :index
    #   expect(assigns(:products)).to match_array(products)
    # end
  
    it 'assigns a new Ransack search to @search' do
      get :index
      expect(assigns(:search)).to be_an_instance_of(Ransack::Search)
    end
  
    it 'assigns all categories to @categories' do
      get :index
      expect(assigns(:categories)).to eq(Category.all)
    end
  end
  

  describe 'GET #new' do
    # it 'assigns a new product to @product' do
    #   get :new
    #   expect(assigns(:product)).to be_a_new(Product)
    # end
  
    it 'assigns a new Ransack search to @search' do
        get :index
      expect(assigns(:search)).to be_an_instance_of(Ransack::Search)
    end
  end
  
  describe 'GET #edit' do
    let(:product) { FactoryBot.create(:product) }
  
    it 'assigns the requested product to @product' do
      get :edit, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end
  
    it 'assigns a new Ransack search to @search' do
        get :index
        expect(assigns(:search)).to be_an_instance_of(Ransack::Search)
      end
  end
  
#   describe 'POST #create' do
#     context 'when user is an admin' do
#       let(:admin_user) { FactoryBot.create(:user, admin: true) }
#       let(:product_params) { FactoryBot.attributes_for(:product) }
  
#       before { sign_in admin_user }

#       it 'creates a new product with valid parameters' do
#         admin_user = FactoryBot.create(:user, admin: true)
#         sign_in admin_user
      
#         expect {
#           p Product.count # Debug statement: print count before creating the product
#           post :create, params: { product: product_params }
#           p Product.count # Debug statement: print count after creating the product
#           p assigns(:product) # Debug statement: print the value of @product
#           p assigns(:product).errors.full_messages # Debug statement: print any error messages
#         }.to change(Product, :count).by(1)
      
#         expect(assigns(:product)).to be_a(Product)
#       end
      
      
  
#       it 'assigns the correct user to the product' do
#         post :create, params: { product: product_params }
#         expect(assigns(:product).user_id).to eq(admin_user.id)
#       end
  
#       it 'redirects to the created product' do
#         post :create, params: { product: product_params }
#         expect(response).to redirect_to(assigns(:product))
#       end
  
#       it 'sets the flash notice' do
#         post :create, params: { product: product_params }
#         expect(flash[:notice]).to eq('Product was created successfully.')
#       end
  
#       it 'renders the new template if product is not saved' do
#         allow_any_instance_of(Product).to receive(:save).and_return(false)
#         post :create, params: { product: product_params }
#         expect(response).to render_template(:new)
#         expect(response).to have_http_status(:unprocessable_entity)
#       end
#     end
  
#     context 'when user is not an admin' do
#       let(:regular_user) { FactoryBot.create(:user, admin: false) }
#       let(:product_params) { FactoryBot.attributes_for(:product) }
  
#       before { sign_in regular_user }
  
#       it 'does not create a new product' do
#         expect {
#           post :create, params: { product: product_params }
#         }.not_to change(Product, :count)
#       end
  
#       it 'sets the flash alert' do
#         post :create, params: { product: product_params }
#         expect(flash[:alert]).to eq('Only admins can create new products')
#       end
  
#       it 'redirects to the root path' do
#         post :create, params: { product: product_params }
#         expect(response).to redirect_to(root_path)
#       end
#     end
#   end
  
#   describe 'PATCH #update' do
#     let(:user) { FactoryBot.create(:user, admin: true) }
#     let(:product) { FactoryBot.create(:product) }

#     before { sign_in user }

#     context 'with valid parameters' do
#       let(:updated_product_params) { FactoryBot.attributes_for(:product, product_title: 'Updated Title') }

#       it 'updates the product' do
#         patch :update, params: { id: product.id, product: updated_product_params }
#         expect(product.reload.product_title).to eq('Updated Title')
#       end

#       it 'attaches the new product image' do
#         image_file = fixture_file_upload('path/to/new_image.jpg', 'image/jpeg')
#         patch :update, params: { id: product.id, product: updated_product_params.merge(image: image_file) }
#         expect(assigns(:product).image).to be_attached
#       end

#       it 'removes the previous product image' do
#         product.image.attach(io: File.open('path/to/old_image.jpg'), filename: 'old_image.jpg')
#         patch :update, params: { id: product.id, product: updated_product_params }
#         expect(product.reload.image).not_to be_attached
#       end

#       it 'redirects to the updated product' do
#         patch :update, params: { id: product.id, product: updated_product_params }
#         expect(response).to redirect_to(assigns(:product))
#       end

#       it 'sets a success flash notice' do
#         patch :update, params: { id: product.id, product: updated_product_params }
#         expect(flash[:notice]).to eq('Product updated successfully')
#       end
#     end

#     context 'with invalid parameters' do
#       let(:invalid_product_params) { FactoryBot.attributes_for(:product, product_title: '') }

#       it 'does not update the product' do
#         patch :update, params: { id: product.id, product: invalid_product_params }
#         expect(product.reload.product_title).not_to eq('')
#       end

#       it 'renders the edit template' do
#         patch :update, params: { id: product.id, product: invalid_product_params }
#         expect(response).to render_template(:edit)
#       end
#     end
#   end

#   describe 'DELETE #destroy' do
#     let(:user) { FactoryBot.create(:user, admin: true) }
#     let!(:product) { FactoryBot.create(:product) }

#     before { sign_in user }

#     it 'destroys the product' do
#       expect {
#         delete :destroy, params: { id: product.id }
#       }.to change(Product, :count).by(-1)
#     end

#     it 'redirects to the products index' do
#       delete :destroy, params: { id: product.id }
#       expect(response).to redirect_to(products_path)
#     end
#   end
end
