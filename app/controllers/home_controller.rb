class HomeController < ApplicationController

  def index
    @categories = Category.all
    @user_name = current_user.user_name
    @featured_products = Product.all.shuffle.last(6)
    @merchants = Merchant.all
  end
end
