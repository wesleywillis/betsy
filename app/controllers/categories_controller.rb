class CategoriesController < ApplicationController

  before_action :require_user, only: [:new, :create]

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    if category.save
      redirect_to merchant_path(@current_user)
    else
      render "new"
    end
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end

end
