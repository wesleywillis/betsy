class AddShippingandTotalsToOrder < ActiveRecord::Migration
  def change
    add_column(:orders, :subtotal, :integer)
    add_column(:orders, :shipping_cost, :integer)
    add_column(:orders, :total_cost, :integer)
    add_column(:orders, :shipping_method, :integer)
  end
end
