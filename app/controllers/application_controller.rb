class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end

#stuff below is Hailey experimenting with stuff learned from codeacademy
#  helper_method :current_user
#
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
