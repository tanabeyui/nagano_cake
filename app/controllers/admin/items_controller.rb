class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_items_path
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :genre_id, :price, :is_active)
  end

end
