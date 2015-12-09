require 'rails_helper'

RSpec.describe MerchantsController, type: :controller do
  let (:merchant) do
    Merchant.create(user_name: "Hagrid", email: "spiderlover@hogwarts.com", password: "123", password_confirmation: "123")
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, id: merchant.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      get :show, id: merchant.id
      expect(subject).to render_template :show
    end
  end
end
