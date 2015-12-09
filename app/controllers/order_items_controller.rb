class OrderItemsController < ApplicationController
  def create
    @order = current_order
    sdfsd
    # if @order.order_items.product_id
    end
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

  # def update
  #   if order_item_params[:quantity].to_i <= @order_item.product.stock.to_i
  #     @order_item.update(order_item_params)
  #     @order_items = @order.order_items
  #     redirect_to order_path(@order)
  #   else
  #     flash[:error] = "Unfortunately we don't have #{order_item_params[:quantity].to_i} #{@order_item.product.name}, only #{@order_item.product.stock.to_i} available"
  #     redirect_to cart_path
  #   end
  # end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :order_id)
  end
end
