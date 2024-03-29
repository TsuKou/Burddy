class Public::ContactsController < ApplicationController
  before_action :authenticate_user!

  def new
    @contact = Contact.new                      # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
  end

  def create
    @contact = Contact.new(contact_params)      # １.&2. データを受け取り新規登録するためのインスタンス作成
    if @contact.save                            # 3. データをデータベースに保存するためのsaveメソッド実行
    flash[:notice] = "投稿に成功しました"
      redirect_to contact_thanks_path           # 4. お問い合わせサンクス画面へリダイレクト
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new                               #失敗したらNewアクションへ遷移
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:shop_id, :user_id, :contact_name, :contact_title, :contact_message)
  end

end
