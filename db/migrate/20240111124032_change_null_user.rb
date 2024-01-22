class ChangeNullUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :last_name, :string, null: true
    change_column :users, :first_name, :string, null: true
    change_column :users, :last_name_kana, :string, null: true
    change_column :users, :first_name_kana, :string, null: true
    change_column :users, :telephone_number, :string, null: true
    change_column :users, :post_code, :string, null: true
    change_column :users, :address, :string, null: true
  end
end
