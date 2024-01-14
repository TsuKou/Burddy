class Favorite < ApplicationRecord
# --ここから--いいね機能のアソシエーション
  belongs_to :user
  # favoriteはuserに属している
  belongs_to :review
  # favoriteはreviewに属している
# --ここまで--
end
