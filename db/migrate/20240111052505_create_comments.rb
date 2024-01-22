class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.integer :review_id    #レビューされた店舗のID
      t.integer :user_id      #コメントしたユーザーのID
      t.text :comment         #コメント本文

      t.timestamps
    end
  end
end
