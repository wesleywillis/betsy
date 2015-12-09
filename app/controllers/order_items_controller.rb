class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order_item = @order.order_items.create(order_item_params)
    session[:order_id] = @order.id
    redirect_to cart_path
  end

  def current_order
    if session[:order_id]
      Order.find(session[:order_id])
    else
      Order.create
    end
  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :order_id)
  end
end
