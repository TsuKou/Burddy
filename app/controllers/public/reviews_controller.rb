class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :des]
  before_action :ensure_correct_user, only: [:edit, :destroy]

  def new
    @review = Review.new(shop_id: params[:shop_id])       # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
  end

  def index # 別ユーザー用の一覧
    @reviews = Review.where(user_id: current_user.id).page(params[:page]).per(5)
    @user = current_user
  end

  def other_user_index
    @o_u_review = Review.where(user_id: params[:id]).page(params[:page]).per(5)
    @user = User.find(params[:id])
  end

  def show
    @review = Review.find(params[:id])
  end

  def user_show # ログインユーザー用の一覧
    @login_users = Review.where(user_id: current_user.id) # Reviewモデル内の特定ユーザーIDのレビューデータをすべて取得
    @user = User.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def create
    @review = current_user.reviews.new(review_params)     # ログインしてるユーザーが持つレビューデータをすべて取り出す
    if @review.save                                       # データをデータベースに保存するためのsaveメソッド実行
    flash[:notice] = "投稿に成功しました"
      redirect_to reviews_path                            # レビュー投稿サンクス画面へリダイレクト
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def update
    review = Review.find(params[:id])
    if review.update(review_params)
      flash[:notice] = "変更を保存しました"
      redirect_to review_path(review)
    else
      flash.now[:alert] = "変更に失敗しました"
      render :edit                                        # 変更保存後操作していたユーザー情報画面へ移動
    end
  end

  def destroy
    @review = Review.find(params[:id])                    # データ(レコード)を1件取得
    @review.destroy                                       # データ(レコード)を削除
    flash[:alert] = "投稿を削除しました"                  # 削除メッセージを表示
    redirect_to reviews_path                              # レビュー投稿一覧画面へリダイレクト
  end

  private

  def review_params
    params.require(:review).permit(:shop_id, :review_title, :review_comment, :category, :star, :image)  # レビュー（ユーザーID, 店舗ID, タイトル、本文、レビュー評価、画像)を保存
  end

  def ensure_correct_user                                 # ログインしているユーザーか判断してアクションを許可する
    @reviews = current_user.reviews
    @review = @reviews.find_by(id: params[:id])
    redirect_to reviews_path unless @review
  end

  def ensure_guest_user                                   # ゲストユーザーがプロフィール編集画面へ遷移、更新させないため
    @review = User.find(params[:id])
    if @user.email == "guest@example.com"                 # ゲストユーザー用メールアドレスか判断する箇所
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
