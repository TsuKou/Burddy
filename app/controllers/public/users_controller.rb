class Public::UsersController < ApplicationController
  def show
    @user = User.all
  end

  def edit
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:review_id)
    @favorite_reviews = Review.find(favorites)
    @review = Review.find(params[:id])
  end
end
