class Genre < ApplicationRecord

  has_many :tagsearches, dependent: :destroy
  # genresテーブルから中間テーブル（tagsearh）に対する関連付け
  has_many :shops, through: :tagsearches, dependent: :destroy
  # genresテーブルから中間テーブル（tagsearh）を介してShopsテーブルへの関連付け
end
