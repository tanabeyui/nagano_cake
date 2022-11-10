class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  def subtotal
    item.add_tax_price * amount
  end
  
  def total_price
    total = 0
    order_details.each do |order_detail|
      order_detail.subtotal
      total += order_detail.subtotal
    end
  end

end
