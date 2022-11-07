class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  with_options presence: true do
    validates :amount
  end
  
  
  def subtotal
    item.add_tax_price * amount
  end

end
