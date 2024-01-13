class Admin::ShopsController < ApplicationController
  def new
    @shop = Shop.new
  end

  def index
    @shops = Shop.all
  end

  def create
    shop = Shop.new(shop_params)
    if shop.save
      redirect_to admin_shop_path(current_user)
    else
      render :new
    end
  end

  def show
    @shops = current_user
    @shop = Shop.find(params[:id])
  end

  private

  def shop_params
    params.require(:shop).permit(:user_id, :review_id, :shop_name, :shop_address, :telephone_number, :business_hours, :regular_holiday, :access_information, :parking, :menu, :remarks, :category )
  end

end
