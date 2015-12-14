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
    @order.status = "pending"
    @order.save
    # Commenting this out... I don't think it will
    # ever get here
    # if @order.save
    redirect_to root_path
    # else
    #   render :new
    # end
  end

  def confirmation
    @order = current_order
    @order.update(order_params) do |o|
      o.card_number = params[:card_number].last(4)
      o.status = "paid"
    end
    update_inventory
    session[:order_id] = nil
  end

  def update_inventory
    @order.order_items.each do |order_item|
      order_item.product.update(inventory: order_item.product.inventory - order_item.quantity)
    end
  end

  def subtotal(order_items)
    sum = 0
    order_items.each do |order_item|
      sum += order_item.quantity * order_item.product.price
    end
    return sum
  end

  private

  def order_params
    params.require(:order).permit(:customer_name, :customer_email, :customer_card_exp_month,
    :customer_card_exp_year, :street_address, :zip_code, :state, :city, :name_on_card, :billing_zip_code)
  end

end
