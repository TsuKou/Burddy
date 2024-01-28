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
  validates :shop_name, presence: true
  validates :shop_address, presence: true
  validates :telephone_number, presence: true
  validates :business_hours, presence: true
  validates :regular_holiday, presence: true

    # favorited_by?(user)メソッドが指定されたユーザーが特定のレビューをいいねしているか判定する物
  # いいねしてなければ「true」していなければ「flase」となる、
  def favorited_by?(user)
    favorites.exists?(user_id: user.id) # exists?メソッドは（）内の条件に合致するレコードかチェックするもの
  end

  # admin側からくるshopの登録情報を保存する

end
