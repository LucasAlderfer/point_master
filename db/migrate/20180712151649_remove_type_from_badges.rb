class RemoveTypeFromBadges < ActiveRecord::Migration[5.1]
  def change
    remove_column :badges, :type, :string
  end
end
