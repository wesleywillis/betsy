require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  before :each do
    @product = Product.create(name: "magic thing", price: 15.0, merchant_id: 1, description: "somethingsomething", photo_url: "stringthing", inventory: 4)
  end

  let (:update_params) do
    {
      product:{
        name: "Screaming Mandrake", price: 15.0, merchant_id: 9, description: "hello", inventory: 100
      },
      id: @product.id
    }
  end

  let (:badupdate_params1) do
    {
      product: { name: "magic thing" },
    id: @product.id
  }
  end

  let (:badupdate_params2) do
    {
      product: {},
      id: @product.id
    }
  end

  let (:bad_params1) do
    {
      product: { name: "magic thing" }
    }
  end

  let (:bad_params2) do
    {
      product: { inventory: -1}
    }
  end

  let (:good_params) do
    {
      product:{ name: "bowwow", price: 15.0, merchant_id: 9, description: "hello", inventory: 100 }
    }

  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new, merchant_id: @product.merchant_id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the new template" do
      get :new, merchant_id: @product.merchant_id
      expect(subject).to render_template :new
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, id: @product.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the show template" do
      get :show, id: @product.id
      expect(subject).to render_template :show
    end
  end

  describe "POST #create" do
    it "redirect to product show page" do
      post :create, good_params
      expect(subject).to redirect_to product_path(assigns(:product))
    end

    it "renders new template on error" do
      post :create, bad_params1
      expect(subject).to render_template :new
    end

    it "renders new template on error" do
      post :create, bad_params2
      expect(subject).to render_template :new
    end
  end

  describe "GET #edit" do
    it "renders the edit view" do
      get :edit, merchant_id: @product.merchant_id, id: @product.id
      expect(subject).to render_template :edit
    end
  end

  describe "PATCH #update" do
    it "redirects to show page" do
      patch :update, update_params
      expect(subject).to redirect_to product_path(update_params[:id])
    end
  end

  describe "DELETE #destroy" do
    it "redirects to merchant show page" do
      Merchant.create(user_name: "Ollivanders", email: "ollie@diagonalley.com", password: "p", password_confirmation: "p")
      delete :destroy, id: @product.id, session: { merchant_id: 1 }
      expect(subject).to redirect_to merchant_path(assigns(:merchant))
    end
  end
end
