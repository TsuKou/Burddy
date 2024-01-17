class Public::HomesController < ApplicationController
  def top
    @Reviews = Review.all
    @shops = Shop.all
  end

  def about
  end
end
