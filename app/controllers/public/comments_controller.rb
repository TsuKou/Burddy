class Public::CommentsController < ApplicationController
  def new
    @comment = Comment.new  # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
  end

  def index
    @comments = Comment.all
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    comment = Comment.new(comment_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    comment.save
    # 4. レビュー投稿サンクス画面へリダイレクト
    redirect_to reviews_thanks_path
  end

  def thanks
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_title,:comment_body)
  end

end
