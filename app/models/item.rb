class Item < ApplicationRecord

  has_one_attached :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :introduction
    validates :genre_id
    validates :price
    validates :is_active
  end

  enum is_active: { on_sale: true, stop_sell: false }



  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

  def add_tax_price
    (self.price * 1.10).round
  end

end
