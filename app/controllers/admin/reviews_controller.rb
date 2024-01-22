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

  def create
    @review = current_user.reviews.new(review_params)

    if @review.save
      redirect_to reviews_path
    else
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:review_id, :user_id, :shop_id, :review_title, :review_comment, :category, :star, :image)
  end

end
