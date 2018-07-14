class Badge < ApplicationRecord
  validates :name, :value, presence: true
  has_many :user_badges
  has_many :badges, through: :user_badges
end
