class Admin::TagsearchesController < ApplicationController
  
  def index
    @shops = Shop.all
  end
  
  def search
    @model = Shop  #search機能とは関係なし
    @word = params[:content]
    @shops = Shop.where("category LIKE?","%#{@word}%")
    redirect_to admin_tagsearches_path
  end
end
