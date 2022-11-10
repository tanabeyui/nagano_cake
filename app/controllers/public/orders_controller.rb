class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
    @addresses = @customer.addresses.all
  end

  def confirm
    @order = Order.new(order_params)
    @customer = current_customer
    @addresses = @customer.addresses.all
    @cart_items = @customer.cart_items.all
    @total = 0
    @order.postage = 800
    if params[:order][:select_address] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "2"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "3"
      @order.postal_code = @order.postal_code
      @order.address = @order.address
      @order.name = @order.name
    else
      render :new
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item.id
        @order_detail.price = cart_item.item.price
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end
    current_customer.cart_items.destroy_all
    redirect_to orders_finished_path
  end

  def finished
  end

  def index
    @customer = current_customer
    @orders = @customer.orders.page(params[:page])
  end

  def show
    @customer = current_customer
    @order = Order.find(params[:id])
    @total = 0
    @order.order_details.each do |order_detail|
      order_detail.subtotal
      @total += order_detail.subtotal
    end
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :payment_price)
  end
end
