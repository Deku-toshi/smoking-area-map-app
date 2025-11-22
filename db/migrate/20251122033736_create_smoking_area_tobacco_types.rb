class CreateSmokingAreaTobaccoTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :smoking_area_tobacco_types do |t|
      t.references :smoking_area, null: false, foreign_key: true
      t.references :tobacco_type, null: false, foreign_key: true

      t.index [:smoking_area_id, :tobacco_type_id], unique: true

      t.timestamps
    end
  end
end
