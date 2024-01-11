class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|

      t.string :genres_name     #店舗メニューの分類（名）

      t.timestamps
    end
  end
end
