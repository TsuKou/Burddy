class Public::TagsearchesController < ApplicationController
  def search
    @model = Shop  #search機能とは関係なし
    @word = params[:content]
    @shops = Shop.where("category LIKE?","%#{@word}%")
    render "tagsearches/tagsearch"
  end
end
