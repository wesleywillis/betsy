class AddShippingToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :carrier_name, :string
    add_column :orders, :shipping_price, :integer
  end
end
