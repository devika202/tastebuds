require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    let(:admin_user) { User.create(username: 'admin', admin: true) }
    let(:regular_user) { User.create(username: 'user', admin: false) }
  
    describe "GET #show" do
      context "when logged in as an admin" do
        before { allow(controller).to receive(:current_user).and_return(admin_user) }
  
        it "renders the show template" do
          user = User.create(username: 'john')
          get :show, params: { id: user.id }
          expect(response).to render_template(:show)
        end
      end
  
      context "when logged in as the requested user" do
        before { allow(controller).to receive(:current_user).and_return(regular_user) }
  
        it "renders the show template" do
          get :show, params: { id: regular_user.id }
          expect(response).to render_template(:show)
        end
      end
  
      context "when logged in as a different user" do
        before { allow(controller).to receive(:current_user).and_return(User.create(username: 'another_user')) }
  
        it "redirects to the root path" do
          get :show, params: { id: regular_user.id }
          expect(response).to redirect_to(root_path)
        end
  
        it "sets the flash alert message" do
          get :show, params: { id: regular_user.id }
          expect(flash[:alert]).to eq("Access denied. You can only view your own profile or as an admin.")
        end
      end
  
      context "when not logged in" do
        it "redirects to the root path" do
          get :show, params: { id: regular_user.id }
          expect(response).to redirect_to(root_path)
        end
      end
    end
  
    describe "GET #index" do
      context "when logged in as an admin" do
        before { allow(controller).to receive(:current_user).and_return(admin_user) }
  
        it "renders the index template" do
          get :index
          expect(response).to render_template(:index)
        end
  
        it "assigns all users to @users" do
          User.create(username: 'user1')
          User.create(username: 'user2')
          get :index
          expect(assigns(:users)).to eq(User.all)
        end
      end
  
      context "when logged in as a regular user" do
        before { allow(controller).to receive(:current_user).and_return(regular_user) }
  
        it "redirects to the root path" do
          get :index
          expect(response).to redirect_to(root_path)
        end
  
        it "sets the flash alert message" do
          get :index
          expect(flash[:alert]).to eq("Only admins can view the users list.")
        end
      end
  
      context "when not logged in" do
        it "redirects to the root path" do
          get :index
          expect(response).to redirect_to(root_path)
        end
      end
    end
  
    describe "GET #new" do
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
  
      it "assigns a new user to @user" do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  
    describe "GET #edit" do
      context "when logged in as an admin" do
        before { allow(controller).to receive(:current_user).and_return(admin_user) }
  
        it "renders the edit template" do
          user = User.create(username: 'john')
          get :edit, params: { id: user.id }
          expect(response).to render_template(:edit)
        end
  
        it "sets the requested user as @user" do
          user = User.create(username: 'john')
          get :edit, params: { id: user.id }
          expect(assigns(:user)).to eq(user)
        end
  
        context "when the requested user is not found" do
          it "redirects to the root path" do
            get :edit, params: { id: 9999 }
            expect(response).to redirect_to(root_path)
          end
  
          it "sets the flash alert message" do
            get :edit, params: { id: 9999 }
            expect(flash[:alert]).to eq("User not found.")
          end
        end
      end
  
      context "when logged in as the requested user" do
        before { allow(controller).to receive(:current_user).and_return(regular_user) }
  
        it "renders the edit template" do
          get :edit, params: { id: regular_user.id }
          expect(response).to render_template(:edit)
        end
  
        it "sets the current user as @user" do
          get :edit, params: { id: regular_user.id }
          expect(assigns(:user)).to eq(regular_user)
        end
      end
  
      context "when logged in as a different user" do
        before { allow(controller).to receive(:current_user).and_return(User.create(username: 'another_user')) }
  
        it "redirects to the root path" do
          get :edit, params: { id: regular_user.id }
          expect(response).to redirect_to(root_path)
        end
  
        it "sets the flash alert message" do
          get :edit, params: { id: regular_user.id }
          expect(flash[:alert]).to eq("Access denied. You can only edit your own profile or as an admin.")
        end
      end
  
      context "when not logged in" do
        it "redirects to the root path" do
          get :edit, params: { id: regular_user.id }
          expect(response).to redirect_to(root_path)
        end
      end
    end
  
    describe "POST #create" do
      let(:valid_params) { { user: { username: 'john', password: 'password' } } }
      let(:invalid_params) { { user: { username: '', password: 'password' } } }
  
      it "creates a new user with valid params" do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end
  
      it "redirects to the root path after successful creation" do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end
  
      it "sets the flash notice message after successful creation" do
        post :create, params: valid_params
        expect(flash[:notice]).to eq("Welcome, john! You have successfully created your account.")
      end
  
      it "assigns a new user to @user with invalid params" do
        post :create, params: invalid_params
        expect(assigns(:user)).to be_a_new(User)
      end
  
      it "renders the new template with invalid params" do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  
    describe "PATCH #update" do
      let(:user) { User.create(username: 'john') }
      let(:valid_params) { { id: user.id, user: { username: 'updated_username' } } }
      let(:invalid_params) { { id: user.id, user: { username: '' } } }
  
      it "updates the user with valid params" do
        patch :update, params: valid_params
        user.reload
        expect(user.username).to eq('updated_username')
      end
  
      it "redirects to the updated user" do
        patch :update, params: valid_params
        expect(response).to redirect_to(user)
      end
  
      it "sets the flash notice message after successful update" do
        patch :update, params: valid_params
        expect(flash[:notice]).to eq("User data updated successfully")
      end
  
      it "assigns the requested user to @user with invalid params" do
        patch :update, params: invalid_params
        expect(assigns(:user)).to eq(user)
      end
  
      it "renders the edit template with invalid params" do
        patch :update, params: invalid_params
        expect(response).to render_template(:edit)
      end
    end
  
    describe "DELETE #destroy" do
      let!(:user) { User.create(username: 'john') }
  
      it "destroys the user" do
        expect {
          delete :destroy, params: { id: user.id }
        }.to change(User, :count).by(-1)
      end
  
      it "redirects to the users list" do
        delete :destroy, params: { id: user.id }
        expect(response).to redirect_to(users_path)
      end
    end
  end
  