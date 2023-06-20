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
  
    it 'assigns all products to @products' do
      get :index
    end
  
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
    it 'assigns a new product to @product' do
      get :new
    end
  
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
  
  describe 'POST #create' do
    context 'when user is an admin' do
      let(:admin_user) { FactoryBot.create(:user, admin: true) }
      let(:product_params) { FactoryBot.attributes_for(:product) }
  
      before { sign_in admin_user }

      it 'creates a new product with valid parameters' do
        admin_user = FactoryBot.create(:user, admin: true)
        sign_in admin_user
      
        expect {
          p Product.count 
          post :create, params: { product: product_params }
          p Product.count 
          p assigns(:product) 
        }
      end
      
      
  
      it 'assigns the correct user to the product' do
        post :create, params: { product: product_params }
      end
  
      it 'redirects to the created product' do
        post :create, params: { product: product_params }
      end
  
      it 'sets the flash notice' do
        post :create, params: { product: product_params }
      end
  
      it 'renders the new template if product is not saved' do
        allow_any_instance_of(Product).to receive(:save).and_return(false)
        post :create, params: { product: product_params }
      end
    end
  
    context 'when user is not an admin' do
      let(:regular_user) { FactoryBot.create(:user, admin: false) }
      let(:product_params) { FactoryBot.attributes_for(:product) }
  
      before { sign_in regular_user }
  
      it 'does not create a new product' do
        expect {
          post :create, params: { product: product_params }
        }.not_to change(Product, :count)
      end
  
      it 'sets the flash alert' do
        post :create, params: { product: product_params }
      end
  
      it 'redirects to the root path' do
        post :create, params: { product: product_params }
        expect(response).to have_http_status(:redirect)    
      end
    end
  end
  
  describe 'PATCH #update' do
    let(:user) { FactoryBot.create(:user, admin: true) }
    let(:product) { FactoryBot.create(:product) }

    before { sign_in user }

    context 'with valid parameters' do
      let(:updated_product_params) { FactoryBot.attributes_for(:product, product_title: 'Product 15') }

      it 'updates the product' do
        patch :update, params: { id: product.id, product: updated_product_params }
      end

      it 'attaches the new product image' do
        image_file = fixture_file_upload('new_image.jpg', 'image/jpeg')
        patch :update, params: { id: product.id, product: updated_product_params.merge(image: image_file) }
        expect(assigns(:product).image).to be_attached
      end

      it 'redirects to the updated product' do
        patch :update, params: { id: product.id, product: updated_product_params }
      end

      it 'sets a success flash notice' do
        patch :update, params: { id: product.id, product: updated_product_params }
      end
    end

    context 'with invalid parameters' do
      let(:invalid_product_params) { FactoryBot.attributes_for(:product, product_title: '') }

      it 'does not update the product' do
        patch :update, params: { id: product.id, product: invalid_product_params }
        expect(product.reload.product_title).not_to eq('')
      end

      it 'renders the edit template' do
        patch :update, params: { id: product.id, product: invalid_product_params }
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { FactoryBot.create(:user, admin: true) }
    let!(:product) { FactoryBot.create(:product) }

    before { sign_in user }

    it 'destroys the product' do
      expect {
        delete :destroy, params: { id: product.id }
      }
    end

    it 'redirects to the products index' do
      delete :destroy, params: { id: product.id }
      expect(response).to have_http_status(:redirect)    
    end
  end
end
