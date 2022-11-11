class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])

    if @order_detail.order.order_status == "wait_payment"
      flash[:danger] = "入金を確認してください！"
      redirect_to admin_order_path(@order_detail.order_id)
      return 0
    elsif @order_detail.order.order_status == "shipping_prepare" || @order_detail.order.order_status == "shipping_finish"
      flash[:danger] = "製作は完了しています！操作できません！"
      redirect_to admin_order_path(@order_detail.order_id)
      return 0
    end

    if params[:order_detail][:making_status] == "making"
      @order_detail.update(order_detail_params)
      @order_detail.order.update(order_status: 2)
      flash[:success] = "製作ステータスを更新しました！製作を開始してください！"
      redirect_to admin_order_path(@order_detail.order_id)

    elsif params[:order_detail][:making_status] == "making_finish" # && すべて"making_finish"の場合に変える
      @order_detail.update(order_detail_params)
      @order_detail.order.update(order_status: 3)
      flash[:warning] = "製作お疲れ様でした！発送の準備をしてください！"
      redirect_to admin_order_path(@order_detail.order_id)

    elsif params[:order_detail][:making_status] == "waiting_making"
      @order_detail.update(order_detail_params)
      flash[:danger] = "製作ステータスを更新しました！製作を開始してください！"
      redirect_to admin_order_path(@order_detail.order_id)

    else
      flash[:danger] = "製作ステータスを変更できません！製作を開始してください！"
      redirect_to admin_order_path(@order_detail.order_id)
    end
  end



  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end

    # if @order_detail.update(order_detail_params)
      # flash[:success] = "製作ステータスを更新しました！"
      # redirect_to admin_order_path(@order_detail.order_id)
    # else
      # redirect_to about_path
    # end