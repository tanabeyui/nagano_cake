class Address < ApplicationRecord

  belongs_to :customer

  with_options presence: true do
    validates :postal_code
    validates :name
    validates :address
  end

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end

end
