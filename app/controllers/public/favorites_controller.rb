class Public::FavoritesController < ApplicationController

  def index
    review_ids = current_user.favorites.pluck(:review_id)
    #現在ログインしてるユーザー情報からfavorite.pluck(:review_id)を抜き出してreview_idsへ代入　pluckメソッドは（）内の特定カラム値だけを取得する
    # likes = Like.where(user_id: @user.id).pluck(:post_id)
    @favorite_reviews = Review.find(review_ids)
    @user = current_user #うまくいなかなければif文使用予定

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
