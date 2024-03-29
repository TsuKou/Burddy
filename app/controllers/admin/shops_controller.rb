class Admin::ShopsController < ApplicationController
  def new
    @shop  = Shop.new
  end

  def index
    @shops = Shop.all.page(params[:page]).per(10)
  end

  def show
    @shops = current_user
    @shop  = Shop.find(params[:id])
  end

  def edit
    @shop  = Shop.find(params[:id])
  end

  def create
    shop   = Shop.new(shop_params)
    if shop.save
      flash[:notice] = "新規登録しました"
      redirect_to admin_shops_path
    else
      flash.now[:alert] = "登録に失敗しました"
      render :new
    end
  end

  def update
    shop  = Shop.find(params[:id])           # URLからアドレスを引っ張ってきてページへ反映
    shop.update!(shop_params)
    flash[:notice] = "変更を保存しました"
    redirect_to admin_shop_path(shop.id)    # 変更保存後操作していたユーザー情報画面へ移動
  end


  private

  def shop_params
    params.require(:shop).permit(:user_id,
                                 :review_id,
                                 :shop_name,
                                 :shop_address,
                                 :telephone_number,
                                 :business_hours,
                                 :regular_holiday,
                                 :access_information,
                                 :parking,
                                 :menu,
                                 :remarks,
                                 :category # 投稿検索機能（タグ）で検索するために必要なパラメーター
    )
  end

end
