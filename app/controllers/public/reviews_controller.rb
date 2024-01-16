class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new  # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    # @shop = Shop.find(params[:shop_id])
  end

  def index
    @reviews = Review.where(user_id: current_user)
    # @user = User.find(params[:id])
  end


  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    review = Review.new(review_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    review.save
    # 4. レビュー投稿サンクス画面へリダイレクト
    redirect_to reviews_thanks_path
  end

  def thanks
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :shop_id, :review_title, :review_comment, :star, :image)
    # レビュー（ユーザーID, 店舗ID, タイトル、本文、レビュー評価、画像)を保存
  end

end
