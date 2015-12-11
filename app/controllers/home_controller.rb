class HomeController < ApplicationController

  def index
    @categories = Category.all
    if current_user.nil?
      @user_name = "Guest"
    else
      @user_name = current_user.user_name
    end
    @featured_products = Product.all.shuffle.last(6)
    @merchants = Merchant.all
  end
end
