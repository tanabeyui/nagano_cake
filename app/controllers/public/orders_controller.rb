class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
    @addresses = @customer.addresses.all
  end

  def confirm
  end

  def finished
  end

  def index
  end

  def show
  end
end
