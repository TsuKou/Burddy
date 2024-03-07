class Admin::TagsearchesController < ApplicationController

  def index
    @shops   = Shop.all
  end

  def search                      # 検索フォームの入力内容を取得
    @model   = Shop                 # search機能とは関係なし
    @word    = params[:content]      # 検索欄に入力した「値」が「:content」に入る
    @keyword = params[:keyword]   # 検索欄に入力した「値」が「:keyword」に入る

    if @word.present? && @keyword.present? # [@word][@keyword]どちらとも入力された場合の対象場所へのあいまい検索する
      @shops = Shop.where("category LIKE ? OR shop_name LIKE ?", "%#{@word}%","%#{@word}%")
                   .where("shop_address LIKE ?", "%#{@keyword}%").page(params[:page]).per(10)
    elsif @word.present?  # [@word]のみ入力検索された際のアクション動作
      @shops = Shop.where("category LIKE ? OR shop_name LIKE ?", "%#{@word}%","%#{@word}%").page(params[:page]).per(10)
    elsif @keyword.present? # [@keyword]のみ入力検索された際のアクション動作
      @shops = Shop.where("shop_address LIKE ?", "%#{@keyword}%").page(params[:page]).per(10)
    else # 何も入力されず検索された場合のアクション動作
      @shops = Shop.all.page(params[:page]).per(10)
    end
  end

end
