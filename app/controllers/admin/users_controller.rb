class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(10)  # 登録しているユーザー情報をすべてuserモデルから取得
  end

  def show
    @user  = User.find(params[:id])                 # URLからアドレスを引っ張ってきてページ表示
  end

  def edit
    @user  = User.find(params[:id])                 # URLからアドレスを引っ張ってきてページ表示
  end

  def update
    @user  = User.find(params[:id])                 # URLからアドレスを引っ張ってきてページへ反映
    if @user.update(user_params)
      flash[:notice] = "変更しました"
      redirect_to admin_user_path(@user)           # 変更保存後操作していたユーザー情報画面へ移動
    else
      flash.now[:alert] = "失敗しました"
      render :edit
    end
  end

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
