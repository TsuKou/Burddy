class Admin::TagsearchesController < ApplicationController

  def index
    @shops = Shop.all
  end

  # def search
  #   @model = Shop  #search機能とは関係なし
  #   @word = params[:content]
  #   if @word.present?
  #     @shops = Shop.where("category LIKE ?", "%#{@word}%")
  #   else

  #   end
  #   # redirect_to admin_tagsearches_path #リダイレクトを指定すると「searchアクション」でデータが入ったものを無視し「上のindexアクション」を読みに行ってしまう
  # end

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
