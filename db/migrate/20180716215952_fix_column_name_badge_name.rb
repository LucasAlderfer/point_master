class FixColumnNameBadgeName < ActiveRecord::Migration[5.1]
  def change
    rename_column :badges, :name, :title
  end
end
