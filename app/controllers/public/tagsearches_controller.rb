class Public::TagsearchesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :search]

  def index
    @shops = Shop.all
    @word = params[:content]
  end

  # def search
    # @model = Shop  #search機能とは関係なし
    # @word = params[:content]
    # @keyword = params[:keyword]
    # if @word.present? #　入力欄に「値：この場合タグ」が入っていればtrue,「値：空」ならfalseとする
    #   # @shops = Shop.where("category LIKE ?", "%#{@word}%") # "%#{@word}%"→ 「% %」を付けることによりあいまい検索させる
    #   @shops = Shop.where("shop_address LIKE ? || shop_name LIKE ?", "%#{@keyword}%", "%#{@word}%" )
    # else
    #   @shops = Shop.all
    # end

    # redirect_to tagsearches_path

  def search # 検索フォームの入力内容を取得
    @model = Shop # search機能とは関係なし
    @word = params[:content]   # 検索欄に入力した「値」が「:content」に入る
    @keyword = params[:keyword] # 検索欄に入力した「値」が「:keyword」に入る

    if @word.present? && @keyword.present?
      @shops = Shop.where("category LIKE ? OR shop_name LIKE ?", "%#{@word}%","%#{@word}%")
                   .where("shop_address LIKE ?", "%#{@keyword}%")
    elsif @word.present?
      @shops = Shop.where("category LIKE ? OR shop_name LIKE ?", "%#{@word}%","%#{@word}%")
    elsif @keyword.present?
      @shops = Shop.where("shop_address LIKE ?", "%#{@keyword}%")
    else
      @shops = Shop.all
    end
  end

end
