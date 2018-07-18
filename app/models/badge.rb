class Badge < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :value, presence: true
  has_many :user_badges
  has_many :users, through: :user_badges

  def enable_badge
    if enabled
      update_attribute(:enabled, false)
    else
      update_attribute(:enabled, true)
    end
  end
end
