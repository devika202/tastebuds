require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:admin_user) { FactoryBot.create(:user, admin: true) }
  let(:category) { FactoryBot.create(:category) }

  describe "GET #new" do
    context "as an admin user" do
      before do
        allow(controller).to receive(:require_admin).and_return(true)
        sign_in admin_user
        get :new
      end

      it "assigns a new Category to @category" do
        expect(assigns(:category)).to be_a_new(Category)
      end
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      before do
        sign_in admin_user
        post :create, params: { category: { name: "New Category" } }
      end

      it "creates a new category" do
        category = FactoryBot.create(:category)
        expect(Category.count).to eq(1)
      end

      it "redirects to the created category" do
        expect(response).to have_http_status(:redirect)    
      end
    end

    context "with invalid parameters" do
      before do
        sign_in admin_user
        post :create, params: { category: { name: "" } }
      end

      it "does not create a new category" do
        expect(Category.count).to eq(0)
      end
    end
  end

  describe "GET #show" do
    context "as an admin user" do
      before do
        sign_in admin_user
        get :show, params: { id: category.id }
      end

      it "assigns the requested category to @category" do
        expect(assigns(:category)).to eq(category)
      end

    end

    context "as a non-admin user" do
      before { get :show, params: { id: category.id } }

      it "redirects to the root path" do
        expect(response).to redirect_to(root_path)
      end
      it "sets a flash alert message" do
        expect(flash[:alert]).to eq("Only admins can perform this action.")
      end
    end
  end

  describe "GET #edit" do
    context "as an admin user" do
      before do
        sign_in admin_user
        get :edit, params: { id: category.id }
      end
    end

    context "as a non-admin user" do
      before { get :edit, params: { id: category.id } }

      it "redirects to the root path" do
        expect(response).to have_http_status(:redirect)    
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      before do
        sign_in admin_user
        patch :update, params: { id: category.id}
      end

      it "updates the category name" do
        category = FactoryBot.create(:category)
        patch :update, params: { id: category.id }
        category.reload
        expect(category.name).to eq(category.name)
      end
    end

    context "with invalid parameters" do
      before do
        sign_in admin_user
        patch :update, params: { id: category.id, category: { name: "" } }
      end

      it "does not update the category" do
        category.reload
        expect(category.name).not_to eq("")
      end

    end
  end

  describe "DELETE #destroy" do
    context "when the category exists" do
      before { sign_in admin_user }
  
      let(:category) { FactoryBot.create(:category) }
  
      it "deletes the category" do
        category = FactoryBot.create(:category)
        expect {delete :destroy, params: { id: category.id }}

      end
      
  
      it "sets a flash notice message" do
        category = FactoryBot.create(:category)
        sign_in admin_user
        delete :destroy, params: { id: category.id }
      end
    end
      
    context "when the category does not exist" do
      before do
        admin_user.confirm
        sign_in admin_user
        delete :destroy, params: { id: category.id }
      end
    
      it "redirects to the categories index" do
        expect(response).to redirect_to(categories_path)
      end
    end
  end    
  
  describe "GET #index" do
    before { get :index }
  
    it "assigns all categories to @categories" do
      category = FactoryBot.create(:category)
      get :index
    end

  end
end