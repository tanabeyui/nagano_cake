class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @genres = Genre.all
    @item = Item.new
  end

  def create
    @genres = Genre.all
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "新しい商品を登録しました！"
      redirect_to admin_item_path(@item)
    else
      flash[:danger] = "未入力の項目があります！"
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
      flash[:success] = "商品情報を変更しました！"
      redirect_to admin_item_path(@item)
    else
      flash[:danger] = "未入力の項目があります！"
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
