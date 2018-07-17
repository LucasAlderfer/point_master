class Admin < ApplicationRecord
  validates :name, :password, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

end
