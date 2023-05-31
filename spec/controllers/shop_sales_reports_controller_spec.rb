require 'rails_helper'

RSpec.describe ShopSalesReportsController, type: :controller do
    let(:user) { create(:user) }
    let(:admin) { create(:user, admin: true) } # Create an admin user with admin field set to true
    let(:shop) { create(:shop) }
    let(:category) { create(:category) }
  
    describe 'GET #index' do
    #   context 'when user is logged in as a shop owner' do
    #     before { sign_in(user) }
  
    #     it "assigns @sales_reports with current shop sales reports" do
    #       shop = create(:shop) # Create a Shop associated with the User
    #       order = create(:order, shop_id: shop.id, user_id: user.id) # Associate the Shop and User with the Order
    #       sales_report = create(:sales_report, shop: shop, order: order) # Associate the Shop and Order with the SalesReport
  
    #       get :index
    #       expect(assigns(:sales_reports)).to eq([sales_report])
    #     end
  
    #     it 'renders the index template' do
    #       get :index
    #       expect(response).to render_template(:index)
    #     end
    #   end
  
      context 'when user is not logged in as a shop owner' do
        it 'redirects to the root path' do
          get :index
          expect(response).to redirect_to(root_path)
        end
      end
    end

  
      
#   describe 'GET #new' do
#     context 'when user is logged in as a shop owner' do
#       before { sign_in(user) }

#       it 'assigns a new sales report' do
#         get :new
#         expect(assigns(:sales_report)).to be_a_new(SalesReport)
#       end

#       it 'assigns all categories' do
#         category # Create a category
#         get :new
#         expect(assigns(:categories)).to eq([category])
#       end

#       it 'renders the new template' do
#         get :new
#         expect(response).to render_template(:new)
#       end
#     end

#     context 'when user is not logged in as a shop owner' do
#       it 'redirects to the root path' do
#         get :new
#         expect(response).to redirect_to(root_path)
#       end
#     end
#   end

#   describe 'POST #create' do
#     let(:valid_params) { attributes_for(:sales_report, category_id: category.id) }
#     let(:invalid_params) { attributes_for(:sales_report, product_name: nil) }

#     context 'when user is logged in as a shop owner' do
#       before { sign_in(user) }

#       context 'with valid parameters' do
#         it 'creates a new sales report' do
#           expect {
#             post :create, params: { sales_report: valid_params }
#           }.to change(SalesReport, :count).by(1)
#         end

#         it 'sets a success flash message' do
#           post :create, params: { sales_report: valid_params }
#           expect(flash[:success]).to eq('Sales report added successfully!')
#         end

#         it 'redirects to the shop dashboard path' do
#           post :create, params: { sales_report: valid_params }
#           expect(response).to redirect_to(shop_dashboard_path)
#         end
#       end

#       context 'with invalid parameters' do
#         it 'does not create a new sales report' do
#           expect {
#             post :create, params: { sales_report: invalid_params }
#           }.not_to change(SalesReport, :count)
#         end

#         it 'assigns all categories' do
#           category # Create a category
#           post :create, params: { sales_report: invalid_params }
#           expect(assigns(:categories)).to eq([category])
#         end

#         it 'displays the error messages' do
#           post :create, params: { sales_report: invalid_params }
#           expect(response).to render_template(:new)
#           expect(flash.now[:alert]).to be_present
#           expect(assigns(:sales_report).errors).not_to be_empty
#         end
#       end
#     end

#     context 'when user is not logged in as a shop owner' do
#       it 'redirects to the root path' do
#         post :create, params: { sales_report: valid_params }
#         expect(response).to redirect_to(root_path)
#       end
#     end
#   end

#   describe 'GET #edit' do
#     let(:sales_report) { create(:sales_report, shop: shop) }

#     context 'when user is logged in as a shop owner' do
#       before { sign_in(user) }

#       it 'assigns the requested sales report' do
#         get :edit, params: { id: sales_report.id }
#         expect(assigns(:sales_report)).to eq(sales_report)
#       end

#       it 'assigns all categories' do
#         category # Create a category
#         get :edit, params: { id: sales_report.id }
#         expect(assigns(:categories)).to eq([category])
#       end

#       it 'renders the edit template' do
#         get :edit, params: { id: sales_report.id }
#         expect(response).to render_template(:edit)
#       end
#     end

#     context 'when user is not logged in as a shop owner' do
#       it 'redirects to the root path' do
#         get :edit, params: { id: sales_report.id }
#         expect(response).to redirect_to(root_path)
#       end
#     end
#   end

#   describe 'PATCH #update' do
#     let(:sales_report) { create(:sales_report, shop: shop) }
#     let(:valid_params) { attributes_for(:sales_report, category_id: category.id) }
#     let(:invalid_params) { attributes_for(:sales_report, product_name: nil) }

#     context 'when user is logged in as a shop owner' do
#       before { sign_in(user) }

#       context 'with valid parameters' do
#         it 'updates the sales report' do
#           patch :update, params: { id: sales_report.id, sales_report: valid_params }
#           sales_report.reload
#           expect(sales_report.product_name).to eq(valid_params[:product_name])
#         end

#         it 'sets a success flash message' do
#           patch :update, params: { id: sales_report.id, sales_report: valid_params }
#           expect(flash[:success]).to eq('Sales report updated successfully!')
#         end

#         it 'redirects to the shop sales reports path' do
#           patch :update, params: { id: sales_report.id, sales_report: valid_params }
#           expect(response).to redirect_to(shop_sales_reports_path)
#         end
#       end

#       context 'with invalid parameters' do
#         it 'does not update the sales report' do
#           patch :update, params: { id: sales_report.id, sales_report: invalid_params }
#           sales_report.reload
#           expect(sales_report.product_name).not_to eq(invalid_params[:product_name])
#         end

#         it 'assigns all categories' do
#           category # Create a category
#           patch :update, params: { id: sales_report.id, sales_report: invalid_params }
#           expect(assigns(:categories)).to eq([category])
#         end

#         it 'displays the error messages' do
#           patch :update, params: { id: sales_report.id, sales_report: invalid_params }
#           expect(response).to render_template(:edit)
#           expect(flash.now[:alert]).to be_present
#           expect(assigns(:sales_report).errors).not_to be_empty
#         end
#       end
#     end

#     context 'when user is not logged in as a shop owner' do
#       it 'redirects to the root path' do
#         patch :update, params: { id: sales_report.id, sales_report: valid_params }
#         expect(response).to redirect_to(root_path)
#       end
#     end
#   end

#   describe 'DELETE #destroy' do
#     let(:sales_report) { create(:sales_report, shop: shop) }

#     context 'when user is logged in as a shop owner' do
#       before { sign_in(user) }

#       it 'deletes the sales report' do
#         expect {
#           delete :destroy, params: { id: sales_report.id }
#         }.to change(SalesReport, :count).by(-1)
#       end

#       it 'sets a success flash message' do
#         delete :destroy, params: { id: sales_report.id }
#         expect(flash[:success]).to eq('Sales report deleted successfully!')
#       end

#       it 'redirects to the shop sales reports path' do
#         delete :destroy, params: { id: sales_report.id }
#         expect(response).to redirect_to(shop_sales_reports_path)
#       end
#     end

#     context 'when user is not logged in as a shop owner' do
#       it 'redirects to the root path' do
#         delete :destroy, params: { id: sales_report.id }
#         expect(response).to redirect_to(root_path)
#       end
#     end
#   end

  describe 'GET #admin_index' do
    # context 'when user is logged in as an admin' do
    #   before { sign_in(admin) }

    #   it 'assigns a new search object' do
    #     get :admin_index
    #     expect(assigns(:search)).to be_a(Ransack::Search)
    #   end

    #   it 'assigns all sales reports with shop and category associations' do
    #     sales_report = create(:sales_report, shop: shop, category: category)
    #     get :admin_index
    #     expect(assigns(:sales_reports)).to eq([sales_report])
    #   end

    #   it 'orders sales reports by date of purchase in descending order' do
    #     sales_report1 = create(:sales_report, shop: shop, category: category, date_of_purchase: 2.days.ago)
    #     sales_report2 = create(:sales_report, shop: shop, category: category, date_of_purchase: 1.day.ago)
    #     get :admin_index
    #     expect(assigns(:sales_reports)).to eq([sales_report2, sales_report1])
    #   end

    #   context 'when search parameters are provided' do
    #     it 'filters sales reports by shop name, product name, or category name' do
    #       shop1 = create(:shop, name: 'Shop1')
    #       shop2 = create(:shop, name: 'Shop2')
    #       category1 = create(:category, name: 'Category1')
    #       category2 = create(:category, name: 'Category2')
    #       sales_report1 = create(:sales_report, shop: shop1, category: category1, product_name: 'Product1')
    #       sales_report2 = create(:sales_report, shop: shop2, category: category2, product_name: 'Product2')
    #       get :admin_index, params: { q: { shop_name_or_category_name_cont: 'Shop' } }
    #       expect(assigns(:sales_reports)).to eq([sales_report1, sales_report2])
    #     end
    #   end

    #   it 'renders the admin_index template' do
    #     get :admin_index
    #     expect(response).to render_template(:admin_index)
    #   end
    # end

    context 'when user is not logged in as an admin' do
      it 'redirects to the root path' do
        get :admin_index
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
