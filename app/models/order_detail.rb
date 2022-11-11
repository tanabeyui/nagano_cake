class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  with_options presence: true do
    validates :price
    validates :amount
  end

  enum making_status: { cannot_start: 0, waiting_making: 1, making: 2, making_finish: 3 }

  def subtotal
    item.add_tax_price * amount
  end

end
