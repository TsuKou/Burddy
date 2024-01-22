class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|

      t.integer :shop_id        #お問い合わせのあった店舗のID
      t.integer :user_id        #お問い合わせしたユーザーのID
      t.string :contact_name    #お問い合わせしたユーザーの名前
      t.string :contact_title   #お問い合わせタイトル
      t.text :contact_message   #お問い合わせ内容本文

      t.timestamps
    end
  end
end
