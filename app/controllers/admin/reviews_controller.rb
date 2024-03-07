class Admin::ReviewsController < ApplicationController

  def index
    @reviews = Review.all.page(params[:page]).per(10)
    @users   = User.all
  end

  def shop_index
    @shop_review_index = Review.where(shop_id: params[:id]).page(params[:page]).per(10) # Reviewモデル内にある店舗IDに関してのレビューをすべて取り出す
    @shop    = Shop.find(params[:id])
  end

  def show
    @review  = Review.find(params[:id])
  end

  def create
    @review  = current_user.reviews.new(review_params)
    if @review.save
      flash[:notice] = "投稿に成功しました"
      redirect_to reviews_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def destroy
    @review  = Review.find(params[:id])    # データ(レコード)を1件取得
    @review.destroy                       # データ(レコード)を削除
    flash[:alert] = "投稿を削除しました"  # 削除メッセージを表示
    redirect_to admin_reviews_path        # レビュー投稿一覧画面へリダイレクト
  end

  private

  def review_params
    params.require(:review).permit(:review_id, :user_id, :shop_id, :review_title, :review_comment, :category, :star, :image)
  end

end
