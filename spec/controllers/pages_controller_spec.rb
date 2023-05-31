require 'rails_helper'

RSpec.describe PagesController, type: :controller do
    describe "GET #home" do
      it "assigns a new Ransack search object to @search" do
        get :home
        expect(assigns(:search)).to be_an_instance_of(Ransack::Search)
        expect(assigns(:search).object_id).not_to eq(Product.ransack.object_id)
      end
  
      it "renders the home template" do
        get :home
        expect(response).to render_template(:home)
      end
    end
  
    describe "GET #about" do
      it "renders the about template" do
        get :about
        expect(response).to render_template(:about)
      end
    end
  end
  