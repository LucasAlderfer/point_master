class User < ApplicationRecord
  validates :name, :password, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :points
  has_many :user_badges
  has_many :badges, through: :user_badges

  # has_secure_password
  def self.authenticate(email, password)
    attempted = find_by(email: email)
    unless attempted.nil?
      if attempted.password == password
        attempted
      else
        nil
      end
    else
      nil
    end
  end

  def point_count
    points.count
  end

end
