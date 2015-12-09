class ProductsController < ApplicationController
  def index
    @products = get_products
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

  def show
    id = params[:id]
    @product = Product.find(id)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
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
    @product = Product.find(id)
  end

  def update
    id = params[:id]
    @product = Product.find(id)
    @product.update(product_params)
    if @product.save
      redirect_to product_path(@product.id)
    else
      render "edit"
    end
  end

  private

<<<<<<< HEAD
  def product_params
    params.permit(product:[:name, :price, :merchant_id, :description, :photo_url, :category_id, :inventory])
  end
=======
def product_params
  params.require(:product).permit(:name, :price, :merchant_id, :description, :photo_url, :inventory)
end
>>>>>>> 7ee8c1cc54815e1d7b2764944c92c41caab3b82a

end
