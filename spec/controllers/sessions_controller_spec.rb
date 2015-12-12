require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  before :each do
    @test_user = Merchant.create(user_name: "Harry Potter", email: "hp@potter.gov", password: "hedwig", password_confirmation: "hedwig")
  end

  let (:login_params) do
    {
      session_data:{
        email: "hp@potter.gov", password: "hedwig"
      }
    }
  end

  let (:bad_login_params) do
    {
      session_data:{
        email: "hedwig@potter.gov", password: "hedwig"
      }
    }
  end

  describe "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    it "redirects to merchant show page" do
      post :create, login_params
      expect(subject).to redirect_to merchant_path(@test_user)
    end

    it "renders new template on error" do
      post :create, bad_login_params
      expect(subject).to render_template :new
    end
  end

  describe "DELETE #destroy" do
    it "redirects to index page" do
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end

  describe "#redirect_if_logged_in" do
    it "redirects to merchant show page if already logged in" do
      post :create, login_params
      get :new
      expect(subject).to redirect_to merchant_path(@test_user)
    end
  end
end
