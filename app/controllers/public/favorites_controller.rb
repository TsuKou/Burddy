class Public::FavoritesController < ApplicationController

  def index
    @favorite = Favorite.find(params[:id])
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
