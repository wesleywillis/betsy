class MerchantsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
    id = params[:id]
    @merchant = Merchant.find(id)
    @products = @merchant.products
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def merchant_params
    params.permit(merchant:[:user_name, :email, :password_digest])
  end
end
