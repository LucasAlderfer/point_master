class AddUserIdToUserBadge < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_badges, :user, index: true, foreign_key: true
  end
end
