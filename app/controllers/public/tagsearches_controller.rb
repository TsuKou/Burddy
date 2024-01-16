class Public::TagsearchesController < ApplicationController

  def index
    @shops = Shop.all
    @word = params[:content]
  end

  def search
    @model = Shop  #search機能とは関係なし
    @word = params[:content] # 検索欄に入力した「値」が「:content」に入る
    if @word.present? #　入力欄に「値：この場合タグ」が入っていればtrue,「値：空」ならfalseとする
      @shops = Shop.where("category LIKE ?", "%#{@word}%") # "%#{@word}%"→ 「% %」を付けることによりあいまい検索させる
    else
      @shops = Shop.all
    end

    # redirect_to tagsearches_path
  end

end
