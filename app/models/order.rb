class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  with_options presence: true do
    validates :postal_code
    validates :address
    validates :name
    validates :postage
    validates :payment_price
    validates :payment_method
  end


  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { wait_payment: 0, confirm_payment: 1, making: 2, shipping_prepare: 3, shipping_finish: 4 }



  def items_total
    total = 0
    self.order_details.each do |order_detail|
      order_detail.subtotal
      total += order_detail.subtotal
    end
    return total
  end

end