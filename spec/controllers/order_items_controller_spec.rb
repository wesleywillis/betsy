require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  describe "POST 'create'" do
    let (:params) do
      {
        order_item:{
          quantity: 1, product_id: 2, order_id: 1
        }
      }
    end

    it "adds an order item to the order" do
      post :create, params
      expect(
    end

    it "updates the quantity of an order item when the order item is already in cart" do

    end

    it "redirects to cart once order item is added" do
      post :create, params
      expect(subject).to redirect_to cart_path
    end
  end

end
