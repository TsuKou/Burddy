class Admin::HomesController < ApplicationController
  before_action :authenticate_admin! #管理者としてログインしていないと表示できない設定
  def top
    @shops   = Shop.all
    @users   = User.all
    @reviews = Review.all
  end
end
