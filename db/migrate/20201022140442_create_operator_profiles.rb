class CreateOperatorProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :operator_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.date :birthdate
      t.references :operator, foreign_key: true

      t.timestamps
    end
  end
end
