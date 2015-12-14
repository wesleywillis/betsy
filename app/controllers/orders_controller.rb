class OrdersController < ApplicationController
  # def new
  #   @order = Order.new
  # end

  def show
    #@order_items = current_merchant.order_items.where(order_id: params[:order_id])
  end

  def cart
    @order = current_order
    @order_items = current_order.order_items
    @subtotal = subtotal(@order_items)
  end

  def checkout
    @order_items = current_order.order_items
    @subtotal = subtotal(@order_items)
  end

  def create
    @order = Order.create
    # Commenting this out... I don't think it will
    # ever get here
    # if @order.save
      redirect_to root_path
    # else
    #   render :new
    # end
  end

  def subtotal(order_items)
    sum = 0
    order_items.each do |order_item|
      sum += order_item.quantity * order_item.product.price
    end
    return sum
  end
end
