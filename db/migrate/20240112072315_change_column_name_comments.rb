class ChangeColumnNameComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :comments_title, :comment_title
  end
end
