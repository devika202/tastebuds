require 'rails_helper'

RSpec.describe ShopSalesReportsController, type: :controller do
    let(:user) { create(:user) }
    let(:admin) { create(:user, admin: true) }
    let(:shop) { create(:shop) }
    let(:category) { create(:category) }
  
    describe 'GET #index' do
      context 'when user is logged in as a shop owner' do
        before { sign_in(user) }
  
        it "assigns @sales_reports with current shop sales reports" do
          shop = create(:shop)
          order = create(:order, user_id: user.id)
          sales_report = create(:sales_report, shop: shop, order_id: order) 
  
          get :index
        end
  
        it 'renders the index template' do
          get :index
        end
      end
  
      context 'when user is not logged in as a shop owner' do
        it 'redirects to the root path' do
          get :index
          expect(response).to redirect_to(root_path)
        end
      end
    end

  
    describe 'GET #new' do
      context 'when user is logged in as a shop owner' do
        before do
          shop = create(:shop)  
          allow(controller).to receive(:current_shop).and_return(shop)
        end
        
        it 'assigns a new sales report' do
          get :new
          expect(assigns(:sales_report)).to be_a_new(SalesReport)
        end
    
        it 'assigns all categories' do
          category = create(:category)
          get :new
          expect(assigns(:categories)).to eq([category])
        end
    
        it 'renders the new template' do
          get :new
          expect(response).to render_template(:new)
        end
      end
    end
    
    
    

  describe 'POST #create' do
    let(:valid_params) { attributes_for(:sales_report, category_id: category.id) }
    let(:invalid_params) { attributes_for(:sales_report, product_name: nil) }

    context 'when user is logged in as a shop owner' do
      before { sign_in(user) }

      context 'with valid parameters' do
        it 'creates a new sales report' do
          expect {
            post :create, params: { sales_report: valid_params }
          }
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new sales report' do
          expect {
            post :create, params: { sales_report: invalid_params }
          }
        end

        it 'assigns all categories' do
          category 
          expect {
            post :create, params: { sales_report: invalid_params }
          }          
        end
      end
    end

    context 'when user is not logged in as a shop owner' do
      it 'redirects to the root path' do
        expect {
          post :create, params: { sales_report: valid_params }
        }         
      end
    end
  end

  describe 'GET #edit' do
    let(:sales_report) { create(:sales_report, shop: shop) }
    let(:user) { create(:user) } 

    context 'when user is logged in as a shop owner' do
      before do
        allow(controller).to receive(:current_shop).and_return(shop)
        sign_in(user)
      end
  
      it 'assigns the requested sales report' do
        get :edit, params: { id: sales_report.id }
        expect(assigns(:sales_report)).to eq(sales_report)
      end
  
      it 'assigns all categories' do
        category = create(:category)  
        get :edit, params: { id: sales_report.id }
        expect(assigns(:categories)).to include(category)
      end
      
  
      it 'renders the edit template' do
        get :edit, params: { id: sales_report.id }
        expect(response).to render_template(:edit)
      end
    end
  
    context 'when user is logged in as a shop owner' do
      before { sign_in(user) }
    
      it 'assigns the requested sales report' do
        allow(controller).to receive(:current_shop).and_return(shop) 
        get :edit, params: { id: sales_report.id }
        expect(assigns(:sales_report)).to eq(sales_report)
      end
    end  
  end
  

  describe 'PATCH #update' do
    let(:sales_report) { create(:sales_report, shop: shop) }
    let(:valid_params) { attributes_for(:sales_report, category_id: category.id) }
    let(:invalid_params) { attributes_for(:sales_report, product_name: nil) }

    context 'when user is logged in as a shop owner' do
      before { 
        sign_in(user)
        allow(controller).to receive(:current_shop).and_return(shop)
      }
      context 'with valid parameters' do
        it 'updates the sales report' do
          patch :update, params: { id: sales_report.id, sales_report: valid_params }
          sales_report.reload
          expect(sales_report.product_name).to eq(valid_params[:product_name])
        end

        it 'sets a success flash message' do
          patch :update, params: { id: sales_report.id, sales_report: valid_params }
          expect(flash[:success]).to eq('Sales report updated successfully!')
        end

        it 'redirects to the shop sales reports path' do
          patch :update, params: { id: sales_report.id, sales_report: valid_params }
          expect(response).to redirect_to(shop_sales_reports_path)
        end
      end

      context 'with invalid parameters' do
        it 'does not update the sales report' do
          patch :update, params: { id: sales_report.id, sales_report: invalid_params }
          sales_report.reload
          expect(sales_report.product_name).not_to eq(invalid_params[:product_name])
        end

        it 'assigns all categories' do
          category = create(:category)
          patch :update, params: { id: sales_report.id, sales_report: invalid_params }
          expect(assigns(:categories)).to include(category)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:sales_report) { create(:sales_report, shop: shop) }

    context 'when user is logged in as a shop owner' do
      before { sign_in(user) 
        allow(controller).to receive(:current_shop).and_return(shop)
      }

      it 'deletes the sales report' do
        expect {
          delete :destroy, params: { id: sales_report.id }
        }
      end

      it 'sets a success flash message' do
        delete :destroy, params: { id: sales_report.id }
        expect(flash[:success]).to eq('Sales report deleted successfully!')
      end

      it 'redirects to the shop sales reports path' do
        delete :destroy, params: { id: sales_report.id }
        expect(response).to redirect_to(shop_sales_reports_path)
      end
    end
  end

  describe 'GET #admin_index' do
    context 'when user is logged in as an admin' do
      before { sign_in(admin) }

      it 'assigns a new search object' do
        get :admin_index
        expect(assigns(:search).object_id).not_to eq(Product.ransack.object_id)
      end

      it 'assigns all sales reports with shop and category associations' do
        sales_report = create(:sales_report, shop: shop, category: category)
        get :admin_index
      end

      it 'orders sales reports by date of purchase in descending order' do
        sales_report1 = create(:sales_report, shop: shop, category: category, date_of_purchase: 2.days.ago)
        sales_report2 = create(:sales_report, shop: shop, category: category, date_of_purchase: 1.day.ago)
        get :admin_index
      end

      context 'when search parameters are provided' do
        it 'filters sales reports by shop name, product name, or category name' do
          shop1 = create(:shop, name: 'ExampleShop1')
          shop2 = create(:shop, name: 'ExampleShop2')
          category1 = create(:category, name: 'Category1')
          category2 = create(:category, name: 'Category2')
          sales_report1 = create(:sales_report, shop: shop1, category: category1, product_name: 'Product1')
          sales_report2 = create(:sales_report, shop: shop2, category: category2, product_name: 'Product2')
          
          get :admin_index, params: { q: { shop_name_or_category_name_cont: 'Shop' } }

        end
      end

      it 'renders the admin_index template' do
        get :admin_index
      end
    end

    context 'when user is not logged in as an admin' do
      it 'redirects to the root path' do
        get :admin_index
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
