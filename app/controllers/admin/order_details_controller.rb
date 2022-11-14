class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:order_detail][:order_detail_id])
    @order = @order_detail.order


    if @order_detail.order.order_status == "wait_payment"
      flash[:danger] = "入金を確認してください！"
      redirect_to admin_order_path(@order.id)
    elsif params[:order_detail][:making_status] == "making"
      @order_detail.update(order_detail_params)
      @order_detail.order.update(order_status: 2)
      flash[:warning] = "製作ステータスを更新しました！製作を開始してください！"
      redirect_to admin_order_path(@order.id)
    else
      @order_detail.update(order_detail_params)
      flash[:warning] = "製作ステータスを更新しました！"
      redirect_to admin_order_path(@order.id)
    end

    if @order.order_details.count == @order.order_details.where(making_status: "making_finish").count
      @order_detail.order.update(order_status: 3)
    end

  end



  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
