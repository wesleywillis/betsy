class HomeController < ApplicationController

  def index
    @categories = Category.all
    @featured_products = Product.all.shuffle.last(10)
    @user_name = current_user.user_name
  end
end
