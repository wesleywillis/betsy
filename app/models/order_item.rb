class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  validates :product_id, presence: true
  validates :order_id, presence: true
  validate :quantity_cannot_be_greater_than_inventory

  def quantity_cannot_be_greater_than_inventory
    if quantity > Product.find(product_id).inventory
      errors.add(:quantity, "Sorry, there are only #{Product.find(product_id).inventory} #{Product.find(product_id).name.pluralize} availible.")
    end
  end
end
