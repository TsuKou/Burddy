class Public::ShopsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:title, :body, :profile_image, :star, :category)
  end
end
