class Public::ShopsController < ApplicationController

  def index
    
  end

  def show
    @shop = Shop.find(params[:id])
  end
  
  def shop_params
    params.require(:shop).permit(:category) 
  end
end
