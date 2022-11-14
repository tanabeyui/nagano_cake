class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if params[:order][:order_status] == "confirm_payment"
      @order.update(order_params)
        @order.order_details.each do |order_detail|
          order_detail.update(making_status: 1)
        end
      flash[:warning] = "入金を確認しました！製作を開始してください！"
      redirect_to admin_order_path(@order)
    elsif params[:order][:order_status] == "shipping_finish" && @order.order_details.count == @order.order_details.where(making_status: "making_finish").count
      @order.update(order_params)
      flash[:success] = "発送しました！お疲れ様でした！"
      redirect_to admin_order_path(@order)
    else
      flash[:danger] = "操作できません！製作ステータスを確認してください！"
      render :show
    end
  end



  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end
