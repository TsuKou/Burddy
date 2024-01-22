class Shop < ApplicationRecord
  belongs_to :user, optional: true

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :contacts, dependent: :destroy

  has_many :tagsearches, dependent: :destroy
  # shopsテーブルから中間テーブル（tagsearch）に対する関連付け
  has_many :genres, through: :tagsearches, dependent: :destroy
  # shopsテーブルから中間テーブル（tagsearch）を介してgenresテーブルへの関連付け


  # カテゴリタグをshopに追加する
  validates :category, presence: true

    # favorited_by?(user)メソッドが指定されたユーザーが特定のレビューをいいねしているか判定する物
  # いいねしてなければ「true」していなければ「flase」となる、
  def favorited_by?(user)
    favorites.exists?(user_id: user.id) # exists?メソッドは（）内の条件に合致するレコードかチェックするもの
  end

  # admin側からくるshopの登録情報を保存する
  def shop_params
  params.require(:shop).permit(:user_id,
                              :review_id,
                              :shop_name,
                              :shop_address,
                              :telephone_number,
                              :business_hours,
                              :regular_holiday,
                              :access_information,
                              :parking,
                              :menu,
                              :remarks,
                              :category # 投稿検索機能（タグ）で検索するために必要なパラメーター
  )
  end

end
