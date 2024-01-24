class Public::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]

  def top
    @Reviews = Review.all
    @shops = Shop.all
  end

  def about
  end
end
