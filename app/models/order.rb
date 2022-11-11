class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  with_options presence: true do
    validates :postal_code
    validates :address
    validates :name
    validates :payment_price
    validates :payment_method
  end


  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { wait_payment: 0, confirm_payment: 1, making: 2, shipping_prepare: 3, shipping_finish: 4 }
                     # {0: 入金待ち, 1:入金確認, 2: 製作中, 3: 発送準備中, 4: 発送済み}
end