class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
