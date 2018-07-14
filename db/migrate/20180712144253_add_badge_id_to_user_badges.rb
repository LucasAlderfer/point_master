class AddBadgeIdToUserBadges < ActiveRecord::Migration[5.1]
  def change
    add_reference :user_badges, :badge, index: true, foreign_key: true
  end
end
