class Merchant < ActiveRecord::Base
  has_many :products
  has_secure_password

  validates :user_name, presence: true, uniqueness: true, length: { maximum: 25 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 50 }

end
