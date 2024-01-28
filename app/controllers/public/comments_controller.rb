class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new  # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @comment.review_id = params[:review_id]
  end

  def index
    @comments = Comment.all
  end

  def user_index
    @user_index = Comment.where(user_id: current_user.id)
  end

  def edit
    @review_comment = Comment.find(params[:id])
  end

  # def edit
  #   @book = Book.find(params[:id])
  #   if @book.user == current_user
  #     render "edit"
  #   else
  #     redirect_to books_path
  #   end
  # end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to user_index_path(@user.id)
    else
      render "edit"
    end
  end


  def create
    @comment = Comment.new(comment_params) # データを受け取り新規登録するためのインスタンス作成
    @comment.user_id = current_user.id

    if @comment.save  # データをデータベースに保存するためのsaveメソッド実行
      flash[:notice] = "投稿に成功しました"
      redirect_to comments_path(@comment.review)
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def destroy #deleteから変更
    @comment = Comment.find(params[:id])
    @comment.find(params[:id]).destroy #「r」が抜けていたため追加
    flash[:alert] = "コメントを削除しました"
    redirect_to reviews_path
  end

  private

  def comment_params
    params.require(:comment).permit(:review_id, :user_id, :comment_title,:comment_body)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
