# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# shop-tagsearch-genreのタグデータ

  # 管理者ログイン情報を以下へ指定
Admin.create!(
  email: 'admin@admin.com',
  password: 'testadmin'
  )

# Tagsearch.create([
#   { genre_id: Genre.find_by(genres_name: 'タグ1')},
#   { genre_id: Genre.find_by(genres_name: 'タグ2')},
#   { genre_id: Genre.find_by(genres_name: 'タグ3')},
#   { genre_id: Genre.find_by(genres_name: 'タグ4')},
#   { genre_id: Genre.find_by(genres_name: 'タグ5')}
#   ])