class AddIconToTobaccoTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :tobacco_types, :icon, :string
  end
end
