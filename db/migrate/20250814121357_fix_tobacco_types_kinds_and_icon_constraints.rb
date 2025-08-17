class FixTobaccoTypesKindsAndIconConstraints < ActiveRecord::Migration[7.1]
  def up
    execute "UPDATE tobacco_types SET kinds = '電子タバコ' WHERE kinds IS NULL"

    execute <<~SQL
      UPDATE tobacco_types SET icon = CASE
        WHEN kinds = '紙タバコ' THEN '🚬'
        WHEN kinds = '電子タバコ' THEN '電子'
        ELSE COALESCE (icon, 'unknown')
      END
      WHERE icon IS NULL;
    SQL

    change_column_null :tobacco_types, :kinds, false
    add_index :tobacco_types, :kinds, unique: true unless index_exists?(:tobacco_types, :kinds, unique: true)
    change_column_null :tobacco_types, :icon, false 
  end

  def down
    change_column_null :tobacco_types, :icon, true
    remove_index :tobacco_types, :kinds if index_exists?(:tobacco_types, :kinds)
    change_column_null :tobacco_types, :kinds, true
  end
end
