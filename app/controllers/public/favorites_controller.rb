class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  #ログインユーザー用のアクション
  def index
    review_ids = current_user.favorites.pluck(:review_id)                                 # 現在ログインしてるユーザー情報からfavorite.pluck(:review_id)を抜き出してreview_idsへ代入,pluckメソッドは（）内の特定カラム値だけを取得する
    @favorite_reviews = Review.where(id: review_ids).page(params[:page]).per(10)
    @user = current_user
  end

  #ログインユーザー以外のユーザー用のアクション
  def other_index
    user = User.find(params[:id])                                                         # 1.URLからuser_idをuserに代入する
    user_ids = user.favorites.pluck(:review_id)                                           # 2.user_idに紐づいてるfavoriteモデルからreview_idのデータを取得する
    @other_favorites = Review.where(id: user_ids).page(params[:page]).per(10)             # 「2.」で代入した値でReviewモデルから指定したユーザーのfavorite(いいね)してるデータのすべてを取得する
    @user = User.find(params[:id])                                                        # URLからuser_idを拾ってきて代入
  end

  def create
    review = Review.find(params[:review_id])
    favorite = current_user.favorites.new(review_id: review.id,shop_id: review.shop_id)   # favorite = その時ログインしているユーザーがレビューに対してのreview_idとreview.idを紐づけする
    favorite.save                                                                         # いいねを保存
    redirect_to request.referer
  end

  def destroy
    review = Review.find(params[:review_id])
    favorite = current_user.favorites.find_by(review_id: review.id)
    favorite.destroy
    redirect_to request.referer
  end

end
