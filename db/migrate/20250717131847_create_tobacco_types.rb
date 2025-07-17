class CreateTobaccoTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :tobacco_types do |t|
      t.string :kinds

      t.timestamps
    end
  end
end
