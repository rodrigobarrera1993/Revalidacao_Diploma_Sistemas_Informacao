class CreateManeuvers < ActiveRecord::Migration[5.2]
  def change
    create_table :maneuvers do |t|
      t.references :vessel, foreign_key: true
      t.float :vessel_displacement, null: false
      t.references :terminal, foreign_key: true
      t.references :operator_profile, foreign_key: true
      t.references :pilot_profile, foreign_key: true
      t.references :relatory, foreign_key: true
      t.date :date_maneuver, null: false
      t.time :time_maneuver, null: false
      t.boolean :is_finished, default: false
      t.string :type_maneuver, null: false

      t.timestamps
    end
  end
end
