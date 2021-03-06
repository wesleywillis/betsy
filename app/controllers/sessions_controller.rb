class SessionsController < ApplicationController
  # require login needs to be created in the ApplicationController to create flash message
  # skip_before_action :require_login, only: [:new, :create]
  before_action :redirect_if_logged_in, only: [:new, :create]
  def new

  end

  def create
  data = params[:session_data]
  @merchant = Merchant.find_by_email(data[:email])
    if !@merchant.nil?
      if @merchant.authenticate(data[:password])
        session[:merchant_id] = @merchant.id
        redirect_to merchant_path(@merchant)
      else # if password doesn't match:
        flash.now[:error] = "Incorrect email or password"
        render :new
      end
    else # user is not in the system (email doesn't match any in database):
      flash.now[:error] = "Incorrect email or password"
      render :new
    end
  end

  def destroy
    session[:merchant_id] = nil
    redirect_to root_path
  end

  def redirect_if_logged_in
    # if the session merchant id exists, find the merchant from that id and if they exist, redirect to their show_page.
    if logged_in?
      redirect_to merchant_path(@current_user)
    end
  end


end
