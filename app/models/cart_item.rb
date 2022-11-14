class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  with_options presence: true do
    validates :amount
  end




  def subtotal
    item.add_tax_price * amount
  end

  def self.items_total(cart_items)
    total = 0
    cart_items.each do |cart_item|
      cart_item.subtotal
      total += cart_item.subtotal
    end
    return total
  end

end
