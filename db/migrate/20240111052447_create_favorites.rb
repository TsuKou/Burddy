class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.integer :user_id #「いいね」したユーザのID
      t.integer :shop_id #「いいね」された店舗のID

      t.timestamps
    end
  end
end
