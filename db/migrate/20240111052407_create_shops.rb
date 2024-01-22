class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|

      t.integer :user_id,         null: false #ユーザーID
      t.integer :review_id,       null: false #レビューID
      t.string :shop_name,        null: false #店舗名
      t.string :telephone_number, null: false #電話番号
      t.string :shop_address,     null: false #住所
      t.string :business_hours,   null: false #営業時間
      t.string :regular_holiday,  null: false #定休日
      t.text :access_information, null: false #アクセス情報
      t.text :parking,            null: false #駐車場
      t.text :menu,               null: false #メニュー
      t.text :remarks,            null: false #備考/注意点
      t.string :tag,              null: false #タグ

      t.timestamps
    end
  end
end
