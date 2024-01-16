class Public::FavoritesController < ApplicationController

  def index
    review_ids = current_user.favorites.pluck(:review_id)
    # likes = Like.where(user_id: @user.id).pluck(:post_id)
    @favorite_reviews = Review.find(review_ids)
    
    
    # @favorite = Favorite.find(params[:id])
  end

  def create
    review = Review.find(params[:review_id])
    favorite = current_user.favorites.new(review_id: review.id) # favorite = その時ログインしているユーザーがレビューに対してのreview_idとreview.idを紐づけする
    favorite.save # いいねを保存
    redirect_to request.referer
  end

  def destroy
    review = Review.find(params[:review_id])
    favorite = current_user.favorites.find_by(review_id: review.id)
    favorite.destroy
    redirect_to request.referer
  end

end
