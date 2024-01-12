class Public::ContactsController < ApplicationController
  def new
    @contact = Contact.new  # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    contact = Contact.new(contact_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    contact.save
    # 4. お問い合わせサンクス画面へリダイレクト
    redirect_to contacts_thanks_path
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:contact_name, :contact_title, :contact_message)
  end

end
