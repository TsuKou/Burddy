class Admin::ReviewsController < ApplicationController

  def index
    @reviews = Review.all
    @users = User.all
  end

  def show
    @review = Review.find(params[:id])
    @user = User.find(params[:id])

    # review_id = Rview.where(review_id)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews_path
  end

end
