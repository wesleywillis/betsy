class OrdersController < ApplicationController
  require 'timeout'

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
    @order = current_order
    @order_items = current_order.order_items
    check_if_quantity_is_available(@order_items)
    @subtotal = subtotal(@order_items)
    @estimates = session[:estimate]
  end

  def estimate
    @order = current_order
    session[:shipping] = "the address information"
    @order.attributes = order_params
    @order.save
    origin = Merchant::MERCHANT_ADDRESS
    destination = { country: 'US', city: @order.city, state: @order.state, zip: @order.zip_code }
    packages = []
    current_order.order_items.each do |orderitem|
      packages.push({weight: orderitem.product.weight, dimensions: orderitem.product.dimensions})
    end
      response = HTTParty.get("http://localhost:3001/shipments/quote",
          :body => { :origin => origin,
                     :destination => destination,
                     :packages => packages,
                   }.to_json,
          :headers => { 'Content-Type' => 'application/json' } )
      if response.code == 400
        # code to handle error message
        session[:shipping] = nil
        flash[:error] = response[0]
        redirect_to checkout_path
      else
        @order = current_order
        @order_items = current_order.order_items
        check_if_quantity_is_available(@order_items)
        @subtotal = subtotal(@order_items)
        @estimates = response
        if @estimates.include?("Failure")
          @error = "This is an error."
        end
        render :checkout
      end
  end

  def change_shipping
    session[:shipping] = nil
    redirect_to checkout_path
  end

  def confirmation
    @order = current_order
    @order.status = "paid"
    @order.attributes = order_params
    @order.card_number = params[:order][:card_number].last(4)
    @order.subtotal = subtotal(@order.order_items)
    shipping_info = params[:estimate].split(",")
    @order.shipping_method = shipping_info[0]
    @order.shipping_cost = shipping_info[1].to_i/100
    @order.total_cost = @order.subtotal + @order.shipping_cost
    @order.order_time = Time.now
    if !@order.save
      render :checkout
    else
      update_inventory
      session[:shipping] = nil
      session[:order_id] = nil
      session[:estimate] = nil
    end
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
    sum = 0
    order_items.each do |order_item|
      sum += order_item.quantity * order_item.product.price
    end
    return sum
  end

  private

  def order_params
    params.require(:order).permit(:customer_name, :customer_email, :customer_card_exp_month, :security_code,
    :customer_card_exp_year, :street_address, :zip_code, :state, :city, :name_on_card, :billing_zip_code)
  end

end
