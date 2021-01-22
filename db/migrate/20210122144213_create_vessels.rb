class CreateVessels < ActiveRecord::Migration[5.2]
  def change
    create_table :vessels do |t|
      t.string :name, null: false
      t.string :mmsi, null: false
      t.float :length, null: false
      t.float :width, null: false
      t.string :type_vessel, null: false
      t.string :url_image, null: false

      t.timestamps
    end
  end
end
