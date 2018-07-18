class User < ApplicationRecord
  validates :name, :password, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :points
  has_many :user_badges
  has_many :badges, through: :user_badges

  enum role: ['default', 'admin']

  has_secure_password

  def point_count
    points.where(active:true).count
  end

  def total_point_count
    points.count
  end

  def spent_points
    points.where(active:false).count
  end

  def badge_display
    badges.pluck(:title).join(', ')
  end

  def redeem_points(amount)
    points.where(active:true).limit(amount).update_all(active: false)
  end

  def delete_points(amount)
    if points.where(active:true).count >= amount
      points.where(active:true).limit(amount).destroy_all
    else
      points.limit(amount).destroy_all
    end
  end
end
