class Point < ApplicationRecord
  belongs_to :user

  def deactivate
    update_attribute(:active, false)
  end
end
