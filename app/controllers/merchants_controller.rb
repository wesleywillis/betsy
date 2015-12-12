class MerchantsController < ApplicationController

  before_action :require_user, only: [:edit, :show]

  def index
  end

  def new
    @merchant = Merchant.new
  end

  def create
    #code below based on the code academy stuff
  #  @merchant = Merchant.new(merchant_params)
  #  if @merchant.save
  #    session[:merchant_id] = @merchant.id
  #    redirect_to '/'
  #  else
  #    redirect_to root_path
  #  end
  end

  def show
    id = @current_user.id
    @merchant = Merchant.find(id)
    @products = @merchant.products
    @orders = @merchant.orders
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
