class OrdersController < ApplicationController
  def new
    @order = Order.new
    raise
  end

  def show
    #@order_items = current_merchant.order_items.where(order_id: params[:order_id])
  end

  def cart
    @order_items = current_order.order_items
    @subtotal = subtotal(@order_items)
  end

  def create
    @order = Order.create(order_params)
    if @order.save
      redirect_to root_path
    else
      render :new
    end
  end

  def subtotal(order_items)
    sum = 0
    order_items.each do |order_item|
      sum += order_item.quantity * order_item.product.price
    end
    return sum
  end
end
