class Shop < ApplicationRecord
  belongs_to :user

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :contacts, dependent: :destroy
  
  has_many :tagsearches, dependent: :destroy
  # shopsテーブルから中間テーブル（tagsearch）に対する関連付け
  has_many :genres, through: :tagsearches, dependent: :destroy
  # shopsテーブルから中間テーブル（tagsearch）を介してgenresテーブルへの関連付け



  validates :category, presence: true

    # favorited_by?(user)メソッドが指定されたユーザーが特定のレビューをいいねしているか判定する物
  # いいねしてなければ「true」していなければ「flase」となる、
  def favorited_by?(user)
    favorites.exists?(user_id: user.id) # exists?メソッドは（）内の条件に合致するレコードかチェックするもの
  end

end
