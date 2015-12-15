class Order < ActiveRecord::Base
  has_many :order_items
  has_many :products, :through => :order_items
  validate :must_have_order_items

  def must_have_order_items
    if status == "paid" || status == "cancelled" || status == "complete"
      validates_presence_of :order_items
    end
  end

  def complete?
    if order_items.all? {|item| item.shipped == true}
      update_attribute(:status, "complete")
    end
  end
end
