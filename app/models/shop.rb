class Shop < ApplicationRecord
  validates :category, presence: true

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :contacts, dependent: :destroy

  belongs_to :user

    # favorited_by?(user)メソッドが指定されたユーザーが特定のレビューをいいねしているか判定する物
  # いいねしてなければ「true」していなければ「flase」となる、
  def favorited_by?(user)
    favorites.exists?(user_id: user.id) # exists?メソッドは（）内の条件に合致するレコードかチェックするもの
  end

end
