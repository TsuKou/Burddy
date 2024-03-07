class Admin::CommentsController < ApplicationController
  
  # 管理者側でコメントを削除する機能
  def destroy
    @comment = Comment.find(params[:id])    # データ(レコード)を1件取得
    @comment.destroy                        # データ(レコード)を削除
    flash[:alert] = "投稿を削除しました"    # 削除メッセージを表示
    redirect_to admin_reviews_path          # レビュー投稿一覧画面へリダイレクト
  end
  
end
