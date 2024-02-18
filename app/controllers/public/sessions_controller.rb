# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

# def user_state
#     user = User.find_by(email: params[:user][:email]) # userモデルの保存データの中から、フォームに入力されたemailに紐づく情報を取得する
#     return if user.nil? # 取得してきたuserのデータが存在するか、ないならメソッド終了
#     return unless user.valid_password?(params[:user][:password]) # 取得したアカウントのパスワードと入力されたパスワードが不一致の場合、このメソッドを終了
#     unless user.is_active == true # 会員ステータスがtrueでないなら新規登録画面に戻る
#       flash[:alert] = "すでに退会しています。"
#       redirect_to new_user_registration_path
#     end

# end
  protected

  # def reject_user # 退会したユーザーのemailとpasswordかを判断して一致したら弾いてエラー表示
  #   user = User.find_by(email: params[:user][:email].downcase)
  #   if user
  #     if (user.valid_password?(params[:user][:password]) && (user.active_for_authentication? == true))
  #       redirect_to new_user_session_path
  #     end
  #   end
  # end

  def user_state
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_active == false)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    else
      flash.now[:alert] = "該当するユーザーが見つかりません"
    end
  end

end
