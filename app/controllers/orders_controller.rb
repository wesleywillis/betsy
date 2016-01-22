class OrdersController < ApplicationController
  require "httparty"
  require 'pry'

  def show
    id = params[:id]
    @order = Order.find(id)
    if @current_user != nil
      if @current_user.orders.include?(@order)
        @order_items = @current_user.order_items.where(order_id: id)
      else
        redirect_to merchant_path(@current_user)
      end
    else
    redirect_to root_path
    end
    # flash[:error] = "Sorry, you are not authorized to view the page you were trying to see.  Here is a better page for you. "
  end

  def cart
    @order = current_order
    @order_items = current_order.order_items
    @subtotal = subtotal(@order_items)
  end

  def checkout
    @order_items = current_order.order_items
    check_if_quantity_is_available(@order_items)
    @subtotal = subtotal(@order_items)
  end

  def confirmation
    @order = current_order
    @order.status = "paid"
    @order.attributes = order_params
    @order.card_number = params[:order][:card_number].last(4)
    @subtotal = subtotal(@order.order_items)
    @order.order_time = Time.now
    if !@order.save
      render :checkout
    else
      update_inventory
      session[:order_id] = nil
    end
  end

  # curl -H "Content-Type: application/json" -X POST --data '{"origin" : { "city" : "Seattle", "state" : "WA", "zip" : "98133" }, "packages" : { }}' http://localhost:3000/rates
  def shipping_estimate
    @order = current_order
    @order_items = current_order.order_items
    @subtotal = subtotal(@order_items)
    response = HTTParty.post("http://localhost:3000/rates",
      :headers => { "Content-Type" => "application/json" },
      #TODO: not hardcode in US destinations?
      :body => {"destination" => { "country" => "US", "city" => "#{@order.city}", "state" => "#{@order.state}", "zip" => "#{@order.zip_code}" }}.to_json
      )
      @ups = response["ups"]
      @usps = response["usps"]
  end

  def confirm_order
    @order = current_order
    @order_items = current_order.order_items
    @subtotal = subtotal(@order_items)
  end

  def check_if_quantity_is_available(order_items)
    order_items.each do |item|
      if item.quantity > item.product.inventory
        if item.product.inventory == 1
          flash[:error] = "Sorry, there is only #{item.product.inventory} #{item.product.name} available."
        elsif item.product.inventory == 0
          flash[:error] = "Sorry, there are no #{item.product.name.pluralize} available."
        else
          flash[:error] = "Sorry, there are only #{item.product.inventory} #{item.product.name.pluralize} available."
        end
        render :cart
      end
    end
  end

  def update_inventory
    @order.order_items.each do |order_item|
      order_item.product.update(inventory: order_item.product.inventory - order_item.quantity)
    end
  end

  def subtotal(order_items)
    @order = current_order
    sum = 0
    order_items.each do |order_item|
      sum += order_item.quantity * order_item.product.price
    end
    if @order.shipping_price
      sum += @order.shipping_price
    end
    #add in shipping cost
    return sum
  end

  private

  def order_params
    params.require(:order).permit(:customer_name, :customer_email, :customer_card_exp_month, :security_code,
    :customer_card_exp_year, :street_address, :zip_code, :state, :city, :name_on_card, :billing_zip_code, :carrier_name, :shipping_price)
  end

end
