class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new(shop_id: params[:shop_id])  # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    # @shop = Review.find(params[:shop_id])
  end

  def index
    @reviews = Review.where(user_id: params[:user_id])
    # review_ids = current_user.shops.pluck(:review_id)
    # @shop_reviews = Review.find(review_ids)
    # @reviews = Review.where(user_id: current_user)
    @user = current_user
    # @user_reviews =
  end

  def show
    @reviews = Review.where(user_id: params[:id])
    # whereメソッドを使用してReviewモデル内にある現在ログインしているユーザーIDに紐づいているレビューデータをすべて取り出す
    @user = User.find(params[:id]) # (params[:id])は一つのデータしか取り出せない
  end

  def user_show
    @login_users = Review.where(user_id: current_user.id)
    @user = User.find(params[:id])
  end

  def create
    # binding.pry #pry-railsコード
    review = current_user.reviews.new(review_params)  #ログインしてるユーザーが持つレビューデータをすべて取り出す
    if review.save                         # 3. データをデータベースに保存するためのsaveメソッド実行
      redirect_to reviews_path     # 4. レビュー投稿サンクス画面へリダイレクト
    else
      # render :new
      redirect_to root_path
    end
  end

  def thanks
  end

  private

  def review_params
    params.require(:review).permit(:shop_id, :review_id, :review_title, :review_comment, :category, :star, :image)
    # レビュー（ユーザーID, 店舗ID, タイトル、本文、レビュー評価、画像)を保存
  end

end
