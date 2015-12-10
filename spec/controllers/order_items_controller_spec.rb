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

    let (:order_id) do
      params[:order_item][:order_id]
    end

    it "adds an order item to the order" do
      post :create, params
      expect(Order.find(order_id).order_items.count).to eq 1
    end

    it "updates the quantity of an order item when the order item is already in cart" do
      order_item2 = OrderItem.create(params[:order_item])
      post :create, params
      expect(OrderItem.find(order_item2.id).quantity).to eq order_item2.quantity + 1
    end

    it "redirects to cart once order item is added" do
      post :create, params
      expect(subject).to redirect_to cart_path
    end
  end
end
