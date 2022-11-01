class Admin::ItemsController < ApplicationController
  def new
    @genres = Genre.all
    @item = Item.new
  end

  def create
    @genres = Genre.all
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render :new
    end
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    
  end

  def edit
    @genres = Genre.all
    @item = Item.find(params[:id])
  end

  def update
    @genres = Genre.all
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end





  private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :genre_id, :price, :is_active)
  end
  
  def add_tax_price
    (self.price * 1.10).round
  end

end
