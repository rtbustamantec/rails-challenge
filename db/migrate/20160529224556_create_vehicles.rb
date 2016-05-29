class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :photo
      t.integer :year
      t.string :make
      t.string :model
      t.string :license_plate
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
