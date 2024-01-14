class Review < ApplicationRecord

  belongs_to :user
  belongs_to :shop
  has_many :comments, dependent: :destroy
  # has_many :favorites, dependent: :destroy
# --ここから--いいね機能のアソシエーション ログインしていないとエラーが表示されるので、対象コントローラー（今回の場合review）に「before_action...」を追加しておくはじめから、そうすると別ページにリダイレクトしてエラー回避
  has_many :favorites, dependent: :destroy
  # いいねはreviewに依存してるからreviewが消えたらいいねも消えるようにする
  def favorited_by?(user)
  # 現在ログインしているユーザーによっていいねされてるか？を判定
    favorites.exists?(user_id: user.id)
  # いいねは存在してる？(いいねを既に押してるか、押していないか)
  end
# --ここまで--

end
