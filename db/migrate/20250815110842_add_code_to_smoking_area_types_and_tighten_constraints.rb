class AddCodeToSmokingAreaTypesAndTightenConstraints < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def up
    execute <<~SQL
    ALTER TABLE smoking_area_types
    ADD COLUMN IF NOT EXISTS code varchar;
    SQL

    execute <<~SQL 
      UPDATE smoking_area_types SET code = icon WHERE code IS NULL;
    SQL

    null_count = select_value(<<~SQL).to_i
      SELECT COUNT(*) FROM smoking_area_types WHERE code IS NULL
    SQL
    if null_count > 0
      raise StandardError, "[smoking_area_types] code に NULL が残っています（#{null_count}件）。seed などのデータ整備をしてから再実行してください。"
    end

    change_column_null :smoking_area_types, :code, false
    change_column_null :smoking_area_types, :name, false
    change_column_null :smoking_area_types, :icon, false
    change_column_null :smoking_area_types, :color, false
    
    add_index :smoking_area_types, :code, unique: true, algorithm: :concurrently unless index_exists?(:smoking_area_types, :code, unique: true)

    execute <<~SQL
      DO $$
      BEGIN
        IF NOT EXISTS (
          SELECT 1 FROM pg_constraint
          WHERE conname = 'chk_smoking_area_types_color_hex'
            AND conrelid = 'smoking_area_types'::regclass
        ) THEN
          ALTER TABLE smoking_area_types
          ADD CONSTRAINT chk_smoking_area_types_color_hex
          CHECK (color ~ '^#[0-9A-Fa-f]{6}$');
        END IF;
      END
      $$;
    SQL
  end

  def down
    execute "ALTER TABLE smoking_area_types DROP CONSTRAINT IF EXISTS chk_smoking_area_types_color_hex;"

    change_column_null(:smoking_area_types, :color, true) if column_exists?(:smoking_area_types, :color)
    change_column_null(:smoking_area_types, :icon,  true) if column_exists?(:smoking_area_types, :icon)
    change_column_null(:smoking_area_types, :name,  true) if column_exists?(:smoking_area_types, :name)
    change_column_null(:smoking_area_types, :code,  true) if column_exists?(:smoking_area_types, :code)

    remove_index :smoking_area_types, :code, if_exists: true
    remove_column :smoking_area_types, :code if column_exists?(:smoking_area_types, :code)
  end
end
