require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

# This controller method isn't used... I think we can delete this test
  # describe "POST 'create'" do
  #   it "creates a new order" do
  #     order_count = Order.all.count
  #     post :create
  #     expect(Order.all.count).to eq order_count + 1
  #   end
  #
  #   # A user won't actually see this-- they will be redirected
  #   # to the cart page, because an order is created when
  #   # an order item is created for the first time
  #   it "redirects to the home page when the order is created" do
  #     post :create
  #     expect(subject).to redirect_to root_path
  #   end
  #
  # end

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

  describe "Logged in functions" do
    let (:merchant) do
      Merchant.create(user_name: "Hailey", email: "spiderlover222@hogwarts.com", password: "123", password_confirmation: "123")
    end

    let (:product) do
      Product.create(name: "testy", price: 10, merchant_id: 1, description: "hi", photo_url: "www.google.com", inventory: 4)
    end

    let (:order_item) do
      OrderItem.create(quantity: 1, product_id: product.id, order_id: 1)
    end

    let (:order) do
      Order.create(status: "pending", order_time: Time.now, customer_name: "Minerva McGonagall", customer_email: "miverva@hogwarts.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Minerva McGonagall" )
    end

    before (:each) do
      session[:merchant_id] = merchant.id
    end

    describe "GET #show" do
      it "responds successfully with an HTTP 200 status code" do
        get :show, id: order.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the show template" do
        get :show, id: order.id
        expect(subject).to render_template :show
      end
    end
  end
end
