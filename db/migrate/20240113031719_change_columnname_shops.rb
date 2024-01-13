class ChangeColumnnameShops < ActiveRecord::Migration[6.1]
  def change
    rename_column :shops, :tag, :category
  end
end
