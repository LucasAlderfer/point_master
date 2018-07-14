class CreateBadges < ActiveRecord::Migration[5.1]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :type
      t.integer :value

      t.timestamps
    end
  end
end
