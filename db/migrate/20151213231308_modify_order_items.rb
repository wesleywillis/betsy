class ModifyOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :status, :boolean
  end
end
