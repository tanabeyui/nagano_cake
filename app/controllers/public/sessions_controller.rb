class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]





  protected

  def customer_state
    @customer = Customer.find_by(email: params[:customer][:email])
    return if !@customer

    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted == "unsubscribe"
      flash[:danger] = "退会済みです！新規会員登録してください！"
      redirect_to new_customer_registration_path
    end
  end

end

