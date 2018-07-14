class AddUserIdToPoints < ActiveRecord::Migration[5.1]
  def change
    add_reference :points, :user, index: true, foreign_key: true
  end
end
