class ProductsController < ApplicationController

  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @products = get_products
    @order_item = current_order.order_items.new
    @categories = Category.all
    @merchants = Merchant.all
    @header = get_header
  end

  def get_products
    if request.original_url.include?("categories")
      products = Category.find(params[:category_id]).products
    elsif request.original_url.include?("merchants")
      products = Product.where("merchant_id = ?", params[:merchant_id])
    else
      products = Product.all
    end
    return products
  end

  def get_header
    if request.original_url.include?("categories")
      header = Category.find(params[:category_id]).name
    elsif request.original_url.include?("merchants")
      header = Merchant.find(params[:merchant_id]).user_name
    else
      header = "All Products"
    end
    return header

  end

  def show
    id = params[:id]
    @product = Product.find(id)
    @order_item = current_order.order_items.new
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    raise
    @product = Product.new(product_params)
    @product.merchant_id = @current_user.id
    if @product.save
      redirect_to product_path(@product)
    else
      render "new"
    end
  end

  def destroy
    id = params[:id]
    product = Product.find(id)
    if product.merchant_id == @current_user.id
      Product.delete(id)
      redirect_to merchant_path(@current_user.id)
    else
      redirect_to product_path(id)
    end
  end

  def edit
    id = params[:id]
    @product = Product.find(id)
    if @product.merchant_id != @current_user.id
      redirect_to product_path(id)
    end
  end

  def update
    id = params[:id]
    @product = Product.find(id)
    if @product.merchant_id != @current_user.id
      redirect_to product_path(@product)
    else
      @product.update(product_params)
      if @product.save
        redirect_to product_path(@product.id)
      else
        render "edit"
      end
    end
  end

  def retire
    item = Product.find(params[:id])
    if item.retire == false
      item.update(retire: true)
    else
      item.update(retire: false)
    end
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :description, :photo_url, :inventory)
  end

end
