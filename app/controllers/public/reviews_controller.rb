class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :destroy]
  # before_action :ensure_guest_user, only: [:edit, :update] # ゲストユーザー用アクセス制限、

  def new
    @review = Review.new(shop_id: params[:shop_id])  # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    # @shop = Review.find(params[:shop_id])
  end

  def index # 別ユーザー用の一覧
    # @reviews = Review.where(user_id: current_user.id)
    @reviews = Review.where(user_id: current_user.id).page(params[:page]).per(5)
    # review_ids = current_user.shops.pluck(:review_id)
    # @shop_reviews = Review.find(review_ids)
    # @reviews = Review.where(user_id: current_user)
    @user = current_user
    # @user_reviews =
  end

  def other_user_index
    @o_u_review = Review.where(user_id: params[:id]).page(params[:page]).per(5)
    @user = User.find(params[:id])
  end

  def show
    @review = Review.find(params[:id])
    # @reviews = User.where(review_id: params[:id])
    # whereメソッドを使用してReviewモデル内にある現在ログインしているユーザーIDに紐づいているレビューデータをすべて取り出す
    # @user = User.find(params[:id]) # (params[:id])は一つのデータしか取り出せない
  end

  def user_show # user_review_path ログインユーザー用の一覧
    @login_users = Review.where(user_id: current_user.id)
    # @login_users = Review.where(user_id: current_user.id) # Reviewモデル内の特定ユーザーIDのレビューデータをすべて取得
    @user = User.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
    # binding.pry #pry-railsコード
    review = current_user.reviews.new(review_params)  #ログインしてるユーザーが持つレビューデータをすべて取り出す
    if review.save                                    # 3. データをデータベースに保存するためのsaveメソッド実行
    flash[:notice] = "投稿に成功しました"
      redirect_to reviews_path                        # 4. レビュー投稿サンクス画面へリダイレクト
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def update
    review = Review.find(params[:id])
    if review.update!(review_params)
      flash[:notice] = "変更を保存しました"
      redirect_to review_path(review)
    else
      flash.now[:alert] = "変更に失敗しました"
      render :edit　　　　　　　　　　　　　　　　# 変更保存後操作していたユーザー情報画面へ移動
    end
  end

  def destroy
    @review = Review.find(params[:id])    # データ(レコード)を1件取得
    @review.destroy                       # データ(レコード)を削除
    flash[:alert] = "投稿を削除しました"  # 削除メッセージを表示
    redirect_to reviews_path            　 # レビュー投稿一覧画面へリダイレクト
  end

  private

  def review_params
    params.require(:review).permit(:shop_id, :review_title, :review_comment, :category, :star, :image)
    # レビュー（ユーザーID, 店舗ID, タイトル、本文、レビュー評価、画像)を保存
  end

  def ensure_correct_user # ログインしているユーザーか判断してアクションを許可する
    @reviews = current_user.reviews
    @review = @reviews.find_by(id: params[:id])
    redirect_to reviews_path unless @review
  end

  def ensure_guest_user # ゲストユーザーがプロフィール編集画面へ遷移、更新させないため
    @review = User.find(params[:id])
    if @user.email == "guest@example.com" # ゲストユーザー用メールアドレスか判断する箇所
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
