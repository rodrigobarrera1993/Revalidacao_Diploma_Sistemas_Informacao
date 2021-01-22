class CreateTerminals < ActiveRecord::Migration[5.2]
  def change
    create_table :terminals do |t|
      t.string :name, null: false
      t.string :cargo, null: false
      t.string :url_image, null: false

      t.timestamps
    end
  end
end
