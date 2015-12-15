class Order < ActiveRecord::Base
  has_many :order_items
  has_many :products, :through => :order_items
  validate :must_have_order_items
  validates :customer_email, presence: true, on: :update, if: :paid?
  validates :street_address, presence: true, on: :update, if: :paid?
  validates :city, presence: true, on: :update, if: :paid?
  validates :zip_code, presence: true, length: {minimum: 5 }, on: :update, if: :paid?
  validates :name_on_card, presence: true, on: :update, if: :paid?
  validates :card_number, presence: true, length: {minimum: 16 }, on: :update, if: :paid?
  validates :customer_card_exp_month, presence: true, numericality: { greater_than: 0 }, on: :update, if: :paid?
validates :customer_card_exp_year, presence: true, numericality: { greater_than: 0 }, on: :update, if: :paid?
  validates :billing_zip_code, presence: true, length: {minimum: 5 }, on: :update, if: :paid?
  validates :security_code, presence: true, length: {minimum: 3 }, on: :update, if: :paid?

  def paid?
    status == "paid"
  end

  def must_have_order_items
    if status == "paid" || status == "cancelled" || status == "complete"
      validates_presence_of :order_items
    end
  end
end
