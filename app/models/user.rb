class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション指定
  has_many :shops, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :contacts, dependent: :destroy
#---------------
  has_many :favorites, dependent: :destroy
  # ユーザーにたくさんのいいねを持つことができるようにする
  # いいねはユーザーに依存してるから、ユーザーが消えたらいいねも消えるようにする
#---------------
  has_many :follows, dependent: :destroy

  validates :last_name, presence: true # presence = validatesで指定した対象データを空でないようにするヘルパー
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :post_code, presence: true, length: { minimum:7,maximum:7}
  validates :address, presence: true
  validates :telephone_number, presence: true, length: { minimum:10,maximum:11}
  validates :user_name, presence: true, length: { minimum:3}

  #ゲストログイン用 User.guestのguestメソッド（機能部分）
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|   #find_or_create_by!とは...データの検索と作成を自動的に判断して処理を行うメソッド
      user.password = SecureRandom.urlsafe_base64           #SecureRandom.urlsafe_base64とは...ランダムな文字列を生成するRubyのメソッドの一種
      # user.name = "guestuser"
    end
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "Guest_user"
      user.last_name = "ゲスト(姓)"
      user.first_name = "ゲスト(名)"
      user.last_name_kana = "ゲスト(セイ)"
      user.first_name_kana = "ゲスト(メイ)"
      user.post_code = "9999999"
      user.address = "ゲスト(住所)"
      user.telephone_number = "99900001111"
    end
  end

  def full_name # 姓と名をあわせフルネームとして表示させる
    self.last_name + " " + self.first_name
  end

  def full_name_kana # 姓カナと名カナをあわせてフルネームとして表示させる
    self.last_name_kana + " " + self.first_name_kana
  end

  def user_status
    if is_active == true  # is_active ? "有効" : "退会"　と記述できるらしい
      "有効"
    else
      "退会"
    end
  end

end
