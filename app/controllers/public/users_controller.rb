class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = User.find(current_user)
  end

  def update
    user = User.find(current_user) # URLからアドレスを引っ張ってきてページへ反映
    user.update!(user_params)
    redirect_to user_path(user) # 変更保存後操作していたユーザー情報画面へ移動
  end

  # def favorite
  #   @user = User.find(params[:id])
  #   favorites = Favorite.where(user_id: @user.id).pluck(:review_id)
  #   @favorite_reviews = Review.find(favorites)
  #   @review = Review.find(params[:id])
  # end

    private

  def user_params
    params.require(:user).permit(:user_name,
                                 :last_name,
                                 :first_name,
                                 :last_name_kana,
                                 :first_name_kana,
                                 :telephone_number,
                                 :email,
                                 :post_code,
                                 :address
                                 )
  end
end
