require 'rails_helper'

RSpec.describe Product, type: :model do
  describe ".validates" do
    it "must have a name" do
      expect(Product.new(name: nil, price: 1, merchant_id: 1, description:"a", photo_url: "http://example.com/picture.jpg", inventory: 1)).to_not be_valid
    end
    it "name must be unique" do
      product = Product.create(name:"Hedwig", price: 1, merchant_id: 1, description:"a", photo_url: "http://example.com/picture.jpg", inventory: 1)
      expect(Product.new(name:"Hedwig", price: 1, merchant_id: 1, description:"a", photo_url: "http://example.com/picture.jpg", inventory: 1)).to_not be_valid
    end
    it "name can have 100 characters" do
      expect(Product.new(name: "a" * 100, price: 1, merchant_id: 1, description:"a", photo_url: "http://example.com/picture.jpg", inventory: 1)).to be_valid
    end
    it "name cannot have 101 characters" do
      expect(Product.new(name: "a" * 101, price: 1, merchant_id: 1, description:"a", photo_url: "http://example.com/picture.jpg", inventory: 1 )).to_not be_valid
    end
    it "must have a price" do
      expect(Product.new(name: "a", merchant_id: 1, description:"a", photo_url: "http://example.com/picture.jpg", inventory: 1)).to_not be_valid
    end
    it "price cannot be a string" do
      expect(Product.new(name: "a", price: "a", merchant_id: 1, description:"a", photo_url: "http://example.com/picture.jpg", inventory: 1)).to_not be_valid
    end
    it "price is a number" do
      product = Product.new(name: "a", price: 1.00, merchant_id: 1, description:"a", photo_url: "http://example.com/picture.jpg", inventory: 1)
      expect(product.price).to be_a(Float)
    end
    it "description can have 500 characters" do
      expect(Product.new(name: "a", price: 1, merchant_id: 1, description: "a" * 500, photo_url: "http://example.com/picture.jpg", inventory: 1)).to be_valid
    end
    it "description cannot have 501 characters" do
      expect(Product.new(name: "a", price: 1, merchant_id: 1, description: "a" * 501, photo_url: "http://example.com/picture.jpg", inventory: 1)).to_not be_valid
    end
    it "price must be greater than 0" do
      expect(Product.new(name: "a", price: -1, merchant_id: 1, description: "a", photo_url: "http://example.com/picture.jpg", inventory: 1)).to_not be_valid
    end
    it "product must belong to a merchant" do
      expect(Product.new(name: "a", price: 1, merchant_id: nil, description: "a", photo_url: "http://example.com/picture.jpg", inventory: 1)).to_not be_valid
    end
    it "inventory must must be greater than 0" do
      expect(Product.new(name: "a", price: 1, merchant_id: 1, description: "a", photo_url: "http://example.com/picture.jpg", inventory: -1)).to_not be_valid
      expect(Product.new(name: "a", price: 1, merchant_id: 1, description: "a", photo_url: "http://example.com/picture.jpg", inventory: 0)).to be_valid
    end
  end
end
