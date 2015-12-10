class MerchantsController < ApplicationController
  def index
  end

  def new
    @merchant = Merchant.new
  end

  def create
    #code below based on the code academy stuff
  #  @merchant = Merchant.new(merchant_params)
  #  if @merchant.save
  #    sessions[:user_id] = @merchant.id
  #    redirect_to '/'
  #  else
  #    redirect_to root_path
  #  end
  end

  def show
    id = params[:id]
    @merchant = Merchant.find(id)
    @products = @merchant.products
    @pending_revenue ||= 0
    @paid_revenue ||= 0
    @complete_revenue ||= 0
    @cancelled_revenue ||= 0
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
