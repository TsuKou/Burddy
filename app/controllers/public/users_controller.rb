class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :update]
  # before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    # user_o = User.find(params[:id])
    # user_c == user_o
    # if
    #   @user = current_user
    # else
    #   @user = User.find(params[:id])
    # end
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user # URLからアドレスを引っ張ってきてページへ反映
    if user.update(user_params)
      flash[:notice] = "変更を保存しました"
      redirect_to mypage_path
    else
      flash.now[:alert] = "変更に失敗しました"
      render :edit# 変更保存後操作していたユーザー情報画面へ移動
    end
  end

  def check

  end

  def withdraw #退会機能
    @user = User.find(current_user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_active: false) # current_userが持つis_activeカラムをfalseにupdateして、退会状態にする
    reset_session # セッション情報をすべて削除
    flash[:alert] = "退会処理を実行いたしました"
    redirect_to root_path # 退会後トップ画面に遷移
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

  def ensure_guest_user # ゲストユーザーがプロフィール編集画面へ遷移、更新させないため
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
