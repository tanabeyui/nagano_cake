class Item < ApplicationRecord

  has_one_attached :image
  belongs_to :genre

  enum is_active: { on_sale: true, stop_sell: false }
  
  
  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

end
