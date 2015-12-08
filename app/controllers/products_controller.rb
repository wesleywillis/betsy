class ProductsController < ApplicationController
  def index
    @products = get_products
    @products = Product.all
  end

  def get_products
    if request.original_url.include?("category")
      products = Product.where("category_id = ?", params[:id])
    elsif request.original_url.include?("merchant")
      products = Product.where("merchant_id = ?", params[:id])
    else
      products = Product.all
    end
    return products
  end

  def show
    id = params[:id]
    @product = Product.find(id)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params[:product])
    if @product.save
      redirect_to product_path(@product)
    else
      render "new"
    end
  end

  def destroy
    id = params[:id]
    Product.delete(id)
    redirect_to products_path
  end

  def edit
    id = params[:id]
    @products = Product.find(id)
  end

  def update
    id = params[:id]
    @product = Product.find(id)
    @product.update(
      name: product_params[:product][:name],
      price: product_params[:product][:price],
      merchant_id: product_params[:product][:merchant_id],
      description: product_params[:product][:description],
      photo_url: product_params[:product][:photo_url],
      category_id: product_params[:product][:category_id],
      inventory: product_params[:product][:inventory],
    )
    if @product.save
      redirect_to product_path(@product.id)
    else
      render "edit"
    end
  end

  private

def product_params
  params.permit(product:[:name, :price, :merchant_id, :description, :photo_url, :category_id, :inventory])
end

end
