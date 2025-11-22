class CreateSmokingAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :smoking_areas do |t|
      t.string :name, null: false
      t.decimal :latitude, precision: 9, scale: 6, null: false
      t.decimal :longitude, precision: 9, scale: 6, null: false
      t.boolean :is_indoor
      t.text :detail
      t.string :address

      t.timestamps
    end
  end
end
