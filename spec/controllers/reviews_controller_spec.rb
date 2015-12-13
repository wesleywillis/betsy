require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let (:review) do
    Review.create(rating: 5, product_id: 2, description: "lovely")
  end

  describe "POST 'create'" do
    let (:params) do
      {
        review:{
          rating: 5, product_id: 2, description: "lovely"
        }
      }
    end

    let (:bad_review_params) do
      {
        review:{
          rating: nil, product_id: 1
        }
      }
    end

# I don't think this is doing anything right now.
    let (:product_id) do
      params[:review][:product_id]
    end
# these two specs are not working.
    it "goes to the product show page if review was successful" do
# testing the next line. get different error. "param for :review is missing"
      post :create, product_id: product_id
      expect(subject).to redirect_to product_path
    end
# error: "no route matches"
    it "renders new page if review was not saved" do
      post :create, bad_review_params
      expect(subject).to render_template :new
    end

  end

# this spec is working.
  describe  "GET #new" do
    it "responds successfully with an HTTP 200 status code" do
      get :new, product_id: review.product_id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end







end
