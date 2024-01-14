class AddReviewIdToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :Review_id, :integer
  end
end
