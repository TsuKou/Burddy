class ChangeNullReview < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :user_id, :integer, null: true
    change_column :reviews, :shop_id, :integer, null: true
  end
end
