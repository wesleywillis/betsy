class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.create(review_params)
    redirect_to product_path
  end


###########################
private

def review_params
  params.require(:review).permit(:rating, :description, :product_id)
end

end
