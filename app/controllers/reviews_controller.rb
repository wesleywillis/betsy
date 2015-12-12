class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.create(review_params)
    @review.product_id = params[:product_id]
    if @review.save
      redirect_to product_path(@review.product_id)
    else
      render "new"
    end
  end

private

def review_params
  params.require(:review).permit(:rating, :description)
end

end
