class ModifyOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :status, :string
  end
end
