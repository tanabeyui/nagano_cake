class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @address = Address.new
    @customer = current_customer
    @addresses = @customer.addresses.all
  end

  def create
    @addresses = Address.all
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:success] = "新しい配送先を登録しました！"
      redirect_to addresses_path
    else
      flash[:danger] = "未入力の項目があります！"
      render :index
    end
  end

  def show
    @address = Address.find(params[:id])
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:success] = "配送先情報を変更しました！"
      redirect_to addresses_path
    else
      flash[:danger] = "未入力の項目があります！"
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end


  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
