class Admin::HomesController < ApplicationController
  before_action :authenticate_admin! #管理者としてログインしていないと表示できない設定
  def top
  end
end
