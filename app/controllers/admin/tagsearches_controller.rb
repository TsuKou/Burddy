class Admin::TagsearchesController < ApplicationController

  def index
    @shops = Shop.all
  end

  def search
    @model = Shop  #search機能とは関係なし
    @word = params[:content]
    if @word.present?
      @shops = Shop.where("category LIKE ?", "%#{@word}%")
    else

    end
    # redirect_to admin_tagsearches_path #リダイレクトを指定すると「searchアクション」でデータが入ったものを無視し「上のindexアクション」を読みに行ってしまう
  end


end
