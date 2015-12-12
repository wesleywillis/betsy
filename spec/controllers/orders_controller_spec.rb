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

  # Need to fill in once method is written in controller
  describe "GET 'show'" do

  end

  describe "GET 'cart'" do
    it "renders the cart template" do
      get :cart
      expect(response).to render_template :cart
    end

    # Not sure how to make this test work... what to put in expect(???)
    # it "displays the total cost of all items in cart" do
    #   order = Order.create
    #   OrderItem.create(quantity: 1, product_id: 2, order_id: order.id)
    #   OrderItem.create(quantity: 2, product_id: 1, order_id: order.id)
    #   OrderItem.create(quantity: 1, product_id: 3, order_id: order.id)
    #   OrderItem.create(quantity: 4, product_id: 4, order_id: order.id)
    #   get :cart
    #   expect(subtotal).to eq 8000
    # end
  end
end
