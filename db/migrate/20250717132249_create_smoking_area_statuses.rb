class CreateSmokingAreaStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :smoking_area_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
