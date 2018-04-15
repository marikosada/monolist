class OwnershipsController < ApplicationController
  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])
    
    
    unless @item.persisted?
    results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)
    
    @item = Item.new(read(results.first))
    @item.save
    end
    
    # Want関係として保存
    if params[:type] == 'Want'
      current_user.want(@item)
      flash[:success] = '商品をWantしました'
    end
    #wantボタンをクリックしたページに戻る
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])
    
    if params[:type] == 'Want'
      current_user.unwant(@item)
      flash[:success] = '商品の Want を解除しました。'
    end
    redirect_back(fallback_location: root_path)
  end
end
