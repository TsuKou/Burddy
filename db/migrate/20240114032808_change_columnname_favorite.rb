class ChangeColumnnameFavorite < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :Review_id, :review_id
  end
end
