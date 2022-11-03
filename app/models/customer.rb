class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :first_name_kana
    validates :last_name_kana
    validates :postal_code
    validates :address
    validates :telephone_number
    validates :email
  end

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  enum is_deleted: { unsubscribe: true, membership: false }

end
