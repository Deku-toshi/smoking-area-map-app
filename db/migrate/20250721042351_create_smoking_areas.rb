class CreateSmokingAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :smoking_areas do |t|
      t.references :user, null: false, foreign_key: true
      t.references :smoking_area_status, null: false, foreign_key: true
      t.references :smoking_area_type, null: false, foreign_key: true
      t.string :name, null: false
      t.decimal :latitude, precision: 9, scale: 6, null: false
      t.decimal :longitude, precision: 9, scale: 6, null: false
      t.boolean :is_indoor
      t.string :available_time_type
      t.time :available_time_start
      t.time :available_time_end
      t.text :detail
      t.string :address, null: false

      t.timestamps
    end
  end
end