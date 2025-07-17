class CreateSmokingAreaTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :smoking_area_types do |t|
      t.string :name
      t.string :icon
      t.string :color

      t.timestamps
    end
  end
end
