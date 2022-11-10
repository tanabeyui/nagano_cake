class Admin::HomesController < ApplicationController

  def top
    @orders = Order.page(params[:page])
    @total_amounts = 0
  end

end
