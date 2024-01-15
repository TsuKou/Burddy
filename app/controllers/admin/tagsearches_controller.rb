class Admin::TagsearchesController < ApplicationController
  
  def index
    
  end
  
  def search
    @model = Shop  #search機能とは関係なし
    @word = params[:content]
    @shops = Shop.where("category LIKE?","%#{@word}%")
    redirect_to admin_tagsersches_path
  end
end
