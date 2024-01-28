class Admin::ReviewsController < ApplicationController

  def index
    @reviews = Review.all
    @users = User.all
  end

  def shop_index
    @shop_review_index = Review.where(shop_id: params[:id]) # Reviewモデル内にある店舗IDに関してのレビューをすべて取り出す
    @shop = Shop.find(params[:id])
  end

  def show
    @review = Review.find(params[:id])
    @user = User.find(params[:id])

    # review_id = Rview.where(review_id)
  end

  def show
    @user = User.find(params[:id])
    @comments = @user.comments.where(user: @user)
  rescue ActiveRecord::RecordNotFound
    # ユーザーが見つからない場合の処理を記述
    flash[:error] = 'ユーザーが存在しません。'
    redirect_to root_path
  end


  def create
    @review = current_user.reviews.new(review_params)

    if @review.save
      flash[:notice] = "投稿に成功しました"
      redirect_to reviews_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])    # データ(レコード)を1件取得
    @review.destroy                       # データ(レコード)を削除
    flash[:alert] = "投稿を削除しました"  # 削除メッセージを表示
    redirect_to admin_reviews_path        # レビュー投稿一覧画面へリダイレクト
  end

  private

  def review_params
    params.require(:review).permit(:review_id, :user_id, :shop_id, :review_title, :review_comment, :category, :star, :image)
  end

end
