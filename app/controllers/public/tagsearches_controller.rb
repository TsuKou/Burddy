class Public::TagsearchesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :search]

  def index
    @shops = Shop.all.page(params[:page]).per(10)
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

    if @word.present? && @keyword.present? # [@word][@keyword]どちらとも入力された場合の対象場所へのあいまい検索する
      @shops = Shop.where("category LIKE ? OR shop_name LIKE ?", "%#{@word}%","%#{@word}%")
                   .where("shop_address LIKE ?", "%#{@keyword}%").page(params[:page]).per(10)
    elsif @word.present? # [@word]のみ入力検索された際のアクション動作
      @shops = Shop.where("category LIKE ? OR shop_name LIKE ?", "%#{@word}%","%#{@word}%").page(params[:page]).per(10)
    elsif @keyword.present? # [@keyword]のみ入力検索された際のアクション動作
      @shops = Shop.where("shop_address LIKE ?", "%#{@keyword}%").page(params[:page]).per(10)
    else # 何も入力されず検索された場合のアクション動作
      @shops = Shop.all.page(params[:page]).per(10)
    end
  end

end
