class AddEnabledToBadges < ActiveRecord::Migration[5.1]
  def change
    add_column :badges, :enabled, :boolean, default: true
  end
end
