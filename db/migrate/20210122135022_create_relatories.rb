class CreateRelatories < ActiveRecord::Migration[5.2]
  def change
    create_table :relatories do |t|
      t.text :maneuver_description
      t.text :vessel_tendecies
      t.integer :maneuver_safety
      t.integer :ladder_safety

      t.timestamps
    end
  end
end
