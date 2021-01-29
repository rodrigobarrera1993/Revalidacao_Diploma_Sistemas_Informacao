class CreatePilotStatistics < ActiveRecord::Migration[5.2]
  def change
    create_table :pilot_statistics do |t|
      t.references :pilot, foreign_key: true
      t.integer :total_maneuvers, default: 0
      t.float :avg_maneuver_safety, default: 0
      t.float :avg_ladder_safety, default: 0

      t.timestamps
    end
  end
end
