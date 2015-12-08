class HomeController < ApplicationController

  def index
    @categories = Category.all
    @featured_products = Product.all.shuffle.last(10)
  end
end
