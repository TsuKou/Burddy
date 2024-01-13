class Public::UsersController < ApplicationController
  def show
    @user = User.all
  end

  def edit
  end

end
