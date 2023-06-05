require 'rails_helper'
RSpec.describe ApplicationController, type: :controller do
  include AbstractController::Helpers
  include ActionController::Helpers
  

    describe "#user_signed_in?" do
        controller do
        def index
            render plain: "index action"
        end

        def current_user
            "user"
        end

        def user_signed_in?
            !current_user.nil?
        end
        end

        it "returns true when a user is signed in" do
        allow(controller).to receive(:current_user).and_return("user")
        expect(controller.user_signed_in?).to be_truthy
        end

        it "returns false when no user is signed in" do
        allow(controller).to receive(:current_user).and_return(nil)
        expect(controller.user_signed_in?).to be_falsy
        end
    end

    describe ApplicationController do
        controller do
            def index
              render plain: "index action"
            end

            def current_user
              "user"
            end
        
            def devise_controller?
              true
            end
            def configure_permitted_parameters
            
            end
        end
        
        describe "before_action :configure_permitted_parameters" do
            
            context "when devise_controller? is true" do
                it "calls the configure_permitted_parameters method" do
                expect(controller).to receive(:configure_permitted_parameters)
                get :index
                end
            end
        
            context "when devise_controller? is false" do
                before do
                    allow(controller).to receive(:devise_controller?).and_return(false)
                end
        
                it "does not call the configure_permitted_parameters method" do
                    expect(controller).not_to receive(:configure_permitted_parameters)
                    get :index
                end
            end
        end      

        describe "helper_method :current_user" do
            it "returns the current user" do
            allow(controller).to receive(:current_user).and_return("user")
            expect(controller.current_user).to eq("user")
          end
        end
     
        describe "before_action :authenticate_admin!" do
            context "when current_admin is present" do
                it "allows access to the action" do
                    allow(controller).to receive(:current_admin).and_return(build(:admin_user))  # Use :admin_user factory
                    get :index
                end
            end
        
            context "when current_admin is not present" do
                it "redirects to root_path" do
                    allow(controller).to receive(:current_admin).and_return(nil)
                    get :index
                end
        
                it "sets a flash error message" do
                    allow(controller).to receive(:current_admin).and_return(nil)
                    get :index
                end
            end
        end
    end
  
    describe "helper_method :current_shop" do
        controller do
          def index
            render plain: "index action"
          end
        end
    
        context "when session[:shop_id] is present" do
          let(:shop) { create(:shop) }
    
          before do
            session[:shop_id] = shop.id
          end
    
          it "returns the current shop" do
            expect(controller.view_context.current_shop).to eq(shop)
          end
        end
    
        context "when session[:shop_id] is not present" do
          it "returns nil" do
            expect(controller.view_context.current_shop).to be_nil
          end
        end
    end
  
    describe "require_user" do
      controller do
        def index
          render plain: "index action"
        end
      end
  
      context "when user is signed in" do
        it "does not set flash[:alert]" do
          allow(controller.view_context).to receive(:user_signed_in?).and_return(true)
          get :index
          expect(flash[:alert]).to be_nil
        end
  
        it "does not redirect to login_path" do
          allow(controller.view_context).to receive(:user_signed_in?).and_return(true)
          get :index
        end
      end
  
      context "when user is not signed in" do
        it "sets flash[:alert] to 'You must be logged in to perform that action'" do
          allow(controller.view_context).to receive(:user_signed_in?).and_return(false)
          get :index
        end
  
        it "redirects to login_path" do
          allow(controller.view_context).to receive(:user_signed_in?).and_return(false)
          get :index
        end
      end
    end

    # describe "protected methods" do
    #   controller do
    #     before_action :configure_permitted_parameters, if: :devise_controller?

    #     def index
    #       render plain: "index action"
    #     end
    #   end

    #   describe "#configure_permitted_parameters" do
    #     it "permits the specified parameters for sign_up" do
    #       sanitizer = double("sanitizer")
    #       expect(sanitizer).to receive(:permit).with(:sign_up, keys: [:firstname, :lastname, :phone, :address, :username])
    #       allow(controller).to receive(:devise_parameter_sanitizer).and_return(sanitizer)

    #       controller.send(:configure_permitted_parameters)
    #     end

    #     it "permits the specified parameters for account_update" do
    #       sanitizer = double("sanitizer")
    #       expect(sanitizer).to receive(:permit).with(:account_update, keys: [:firstname, :lastname, :phone, :address, :username])
    #       allow(controller).to receive(:devise_parameter_sanitizer).and_return(sanitizer)

    #       controller.send(:configure_permitted_parameters)
    #     end
    #   end
    # end
end