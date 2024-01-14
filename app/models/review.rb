class Review < ApplicationRecord

  has_many :comments, dependent: :destroy
  # has_many :favorites, dependent: :destroy
# --ここから--いいね機能のアソシエーション
  has_many :favorites, dependet: :destroy
  # いいねはreviewに依存してるからreviewが消えたらいいねも消えるようにする
  def favorited_by?(user)
  # 現在ログインしているユーザーによっていいねされてるか？を判定
    favorites.exists?(user_id: user.id)
  # いいねは存在してる？(いいねを既に押してるか、押していないか)
  end
# --ここまで--

end
