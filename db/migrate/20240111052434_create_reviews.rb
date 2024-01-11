class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer :user_id,       null: false #レビューしたユーザーのID
      t.integer :shop_id,       null: false #レビューされた店舗のID
      t.string :review_title,   null: false #レビュータイトル
      t.text :review_comment,   null: false #レビューコメント本文

      t.timestamps
    end
  end
end
