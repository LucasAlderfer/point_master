class Admin < ApplicationRecord
  validates :name, :password, presence: true
  validates :email, presence: true, uniqueness: true

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

end
