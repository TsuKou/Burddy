class Review < ApplicationRecord

  belongs_to :user
  belongs_to :shop
  has_many :comments, dependent: :destroy
  # has_many :favorites, dependent: :destroy
# --ここから--いいね機能のアソシエーション ログインしていないとエラーが表示されるので、対象コントローラー（今回の場合review）に「before_action...」を追加しておくはじめから、そうすると別ページにリダイレクトしてエラー回避
  has_many :favorites, dependent: :destroy

  has_one_attached :image #reviewで画像を表示する為


  # いいねはreviewに依存してるからreviewが消えたらいいねも消えるようにする
  def favorited_by?(user)
  # 現在ログインしているユーザーによっていいねされてるか？を判定
    favorites.exists?(user_id: user.id)
  # いいねは存在してる？(いいねを既に押してるか、押していないか)
  end
# --ここまで--

  def self.favorites(user) # モデル内での操作を開始 (user,page, per_page)
    includes(favorites) # favoritesテーブルを結合
      .where(favorite: {user_id: user.id}) # ユーザーがいいねしたレコードを絞り込み
      .order(created_at: :desc) # 投稿を作成日時の降順でソート
      # .page(page) # 5. ページネーションのため、指定ページに表示するデータを選択
      # .per(per_page) # 6. ページごとのデータ数を指定
  end

end
