class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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

#stuff below is Hailey experimenting with stuff learned from codeacademy
#  helper_method :current_user
#
#	def current_user
#  	@current_user ||= Merchant.find(session[:merchant_id]) if 	session[:merchant_id]
#	end
#
#  def require_user
#  	redirect_to '/login' unless current_user
#	end
#

end
