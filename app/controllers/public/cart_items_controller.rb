class Public::CartItemsController < ApplicationController
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    now_cart_item = current_customer.cart_items.find_by(item_id: @cart_item.item_id)
    if params[:cart_item][:amount] == ""
      @genres = Genre.all
      @item = Item.find(params[:cart_item][:item_id])
      @cart_item = CartItem.new
      render 'public/items/show'
      return 0
    end
    if now_cart_item
      now_cart_item.update(amount: now_cart_item.amount + @cart_item.amount.to_i)
      redirect_to cart_items_path
    elsif now_cart_item == nil
      @cart_item.save
      redirect_to cart_items_path
    end
  end

  def index
    @customer = current_customer
    @cart_items = @customer.cart_items.all
    @total = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      redirect_to cart_items_path
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end
