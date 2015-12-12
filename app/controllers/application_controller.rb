class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user

  def current_order

    return @order if @order
    if !session[:order_id].nil?
      @order = Order.find(session[:order_id])
    else
      @order = Order.create
      session[:order_id] = @order.id
      return @order
     end
  end

	def current_user
 	  @current_user ||= Merchant.find(session[:merchant_id]) if session[:merchant_id]
	end

  def require_user
    if current_user.nil?
      flash[:error] = "Please log in to view this section"
 	    redirect_to new_session_path
    end
  end
end
