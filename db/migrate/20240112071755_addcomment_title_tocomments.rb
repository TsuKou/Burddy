class AddcommentTitleTocomments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :comments_title, :string
  end
end
