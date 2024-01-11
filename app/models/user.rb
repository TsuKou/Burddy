class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #ゲストログイン用 User.guestのguestメソッド（機能部分）
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|   #find_or_create_by!とは...データの検索と作成を自動的に判断して処理を行うメソッド
      user.password = SecureRandom.urlsafe_base64           #SecureRandom.urlsafe_base64とは...ランダムな文字列を生成するRubyのメソッドの一種
      # user.name = "guestuser"
    end
  end

end
