require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  describe ".validates" do
    it "creates a new order item with order id, product id and quantity" do
        expect(OrderItem.new(product_id: 1, order_id: 1, quantity: 1 )).to be_valid
    end
    it "must belong to a product" do
      expect(OrderItem.new(order_id: 1, quantity: 1 )).to_not be_valid
    end
    it "must belong to an order" do
      expect(OrderItem.new(product_id: 1, quantity: 1 )).to_not be_valid
    end
    it "must have a quantity" do
      expect(OrderItem.new(product_id: 1, order_id: 1 )).to_not be_valid
    end
    it "quantity must be an integer" do
      expect(OrderItem.new(product_id: 1, order_id: 1, quantity: "a")).to_not be_valid
    end
    it "quantity must be greater than 0" do
      expect(OrderItem.new(product_id: 1, order_id: 1, quantity: -1)).to_not be_valid
    end
    it "quantity cannot be 0" do
      expect(OrderItem.new(product_id: 1, order_id: 1, quantity: 0)).to_not be_valid
    end
  end
end
