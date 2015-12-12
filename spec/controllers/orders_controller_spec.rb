require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "POST 'create'" do
    it "creates a new order" do
      order_count = Order.all.count
      post :create
      expect(Order.all.count).to eq order_count + 1
    end

    # A user won't actually see this-- they will be redirected
    # to the cart page, because an order is created when
    # an order item is created for the first time
    it "redirects to the home page when the order is created" do
      post :create
      expect(subject).to redirect_to root_path
    end

  end

  describe "GET 'show'" do

  end

  describe "GET 'cart'" do

  end

  describe "subtotal" do

  end

end
