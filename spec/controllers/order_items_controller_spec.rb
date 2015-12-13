require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let (:product) do
    Product.create(name: "testy", price: 10, merchant_id: 1, description: "hi", photo_url: "www.google.com", inventory: 4)
  end

  let (:order_item) do
    OrderItem.create(quantity: 1, product_id: product.id, order_id: 1)
  end

  describe "POST 'create'" do
    let (:params) do
      {
        order_item:{
          quantity: 1, product_id: product.id, order_id: 1
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
      order_item3 = OrderItem.create(params[:order_item])
      post :create, params
      expect(OrderItem.find(order_item3.id).quantity).to eq order_item3.quantity + 1
    end

    it "does not allow quantity of an order item to be greater than the product inventory" do
      params =
        {
          order_item:{
            quantity: 7, product_id: product.id, order_id: 1
          }
        }

      post :create, params
      expect(Order.find(params[:order_item][:order_id]).order_items.count).to eq 0
    end

    it "redirects to cart once order item is added" do
      post :create, params
      expect(subject).to redirect_to cart_path
    end
  end

  describe "DELETE 'destroy'" do
    it "removes the order item from the order" do
      delete :destroy, id: order_item.id
      expect(Order.find(order_item.id).order_items.count).to eq 0
    end

    it "redirects to the cart page once order item is deleted" do
      delete :destroy, id: order_item.id
      expect(subject).to redirect_to cart_path
    end
  end

  describe "PATCH 'update'" do
    let (:update_params) do
      {
        order_item:{
          quantity: 3, product_id: product.id, order_id: 1
        },
        id: order_item.id
      }
    end

    it "updates the quantity of the order item" do
      patch :update, update_params
      expect(OrderItem.find(order_item.id).quantity).to eq update_params[:order_item][:quantity]
    end

    # Need to refactor test so this works.
    # it "does not allow quantity of an order item to be greater than the product inventory" do
    #   bad_params =
    #     {
    #       order_item:{
    #         quantity: 7, product_id: product.id, order_id: 1
    #       },
    #       id: order_item.id
    #     }
    #
    #   patch :update, bad_params
    #   expect(Order.find(bad_params[:order_item][:order_id]).order_items.count).to eq 1
    # end

    it "redirects to the cart page once the order item is updated" do
      patch :update, update_params
      expect(subject).to redirect_to cart_path
    end
  end
end
