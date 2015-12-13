class QuantityValidator < ActiveModel::Validator
  def validate(order_item)
    unless order_item.quantity <= order_item.product.inventory
      order_item.errors[:quantity] << "Sorry, there are only #{order_item.product.inventory} #{order_item.product.name.pluralize} availible.")
    end
  end
end
