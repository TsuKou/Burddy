class ChangeNullShops < ActiveRecord::Migration[6.1]
  def change
    change_column :shops, :user_id, :integer, null: true
    change_column :shops, :review_id, :integer, null: true
    change_column :shops, :access_information, :text, null: true
    change_column :shops, :parking, :text, null: true
    change_column :shops, :menu, :text, null: true
    change_column :shops, :remarks, :text, null: true
    change_column :shops, :tag, :string, null: true
  end
end
