class Public::CommentsController < ApplicationController
  def new
    @comment = Comment.new  # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    
  end

  def index
    @comments = Comment.all
  end

  def create
    comment = Comment.new(comment_params) # データを受け取り新規登録するためのインスタンス作成
    comment.save  # データをデータベースに保存するためのsaveメソッド実行
    redirect_to reviews_thanks_path # コメント投稿サンクス画面へリダイレクト
  end
  
  def destroy
  end

  def thanks
  end

  private

  def comment_params
    params.require(:comment).permit(:review_id, :user_id, :comment_title,:comment_body)
  end

end
