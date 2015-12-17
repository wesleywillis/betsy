class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.create(review_params)
    @review.product_id = params[:product_id]

    if @current_user.products.include?!(@review.product_id) || @current_user == nil
      if @review.save
        redirect_to product_path(@review.product)
      else
        render "new"
      end
    else
      redirect_to product_path(@review.product_id)
    end
    flash[:error] = "You aren't allowed to review your own products.  Stop being Slytherin."
  end

private

  def review_params
    params.require(:review).permit(:rating, :description)
  end
end
