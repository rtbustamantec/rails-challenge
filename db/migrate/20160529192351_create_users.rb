class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :mobile_number
      t.string :verification_code
      t.boolean :is_verified
      t.string :name
      t.string :email
      t.string :photo

      t.timestamps null: false
    end
  end
end
