class ChangeCloumnNameReviews < ActiveRecord::Migration[6.1]
  def change
    rename_column :reviews, :Category, :category
  end
end
