class CreateTobaccoTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :tobacco_types do |t|
      t.string :name, null: false
      t.string :icon, null: false
      t.integer :display_order, null: false, default: 0

      t.timestamps
    end

    add_index :tobacco_types, :name, unique: true
    add_index :tobacco_types, :display_order, unique: true
  end
end
