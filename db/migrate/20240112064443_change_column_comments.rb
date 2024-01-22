class ChangeColumnComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :comment, :comment_body
  end
end
