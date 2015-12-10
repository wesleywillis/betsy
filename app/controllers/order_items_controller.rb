class OrderItemsController < ApplicationController
  before_action :check_if_product_is_in_cart, only: [:create]

  def create
    @order = current_order
    @order_item = @order.order_items.create(order_item_params)
    session[:order_id] = @order.id
    redirect_to cart_path
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items

    redirect_to(:back)
  end

  def current_order
    if session[:order_id]
      Order.find(session[:order_id])
    else
      Order.create
    end
  end

  def check_if_product_is_in_cart
    order = current_order
    @product_id = params[:order_item][:product_id]
    product_in_cart = order.order_items.select {|order_item| order_item.product_id == @product_id.to_i}

    if !product_in_cart.nil?
      update_product_in_cart(product_in_cart[0])
    end
  end

  def update_product_in_cart(product_in_cart)
    current_quantity = product_in_cart.quantity
    additional_quantity = params[:order_item][:quantity].to_i
    params[:order_item][:quantity] = current_quantity + additional_quantity

    product_in_cart.update_attributes(order_item_params)

    redirect_to cart_path

  end

  private

  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :order_id)
  end
end
