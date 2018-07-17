class Badge < ApplicationRecord
  validates :title, :value, presence: true
  has_many :user_badges
  has_many :users, through: :user_badges
end
