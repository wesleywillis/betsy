class Product < ActiveRecord::Base
  has_many :reviews
  belongs_to :merchant
  has_and_belongs_to_many :categories
  has_many :order_items
end
