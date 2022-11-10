class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum making_status: { cannot_start: 0, waiting_making: 1, making: 2, finish_making: 3 }

  def subtotal
    item.add_tax_price * amount
  end

end
