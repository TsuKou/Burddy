class Public::HomesController < ApplicationController
  before_action :authenticate_user!, only: [:top, :about]
  
  def top
    @Reviews = Review.all
    @shops = Shop.all
  end

  def about
  end
end
