class FixReportsColumns < ActiveRecord::Migration[7.1]
  def up
    execute "UPDATE reports SET reason = 'unspecified' WHERE reason IS NULL"
    change_column_null :reports, :reason, false
    remove_column :reports, :target_type, :string if column_exists?(:reports, :target_type)
  end

  def down
    add_column :reports, :target_type, :string unless column_exists?(:reports, :target_type)
    change_column_null :reports, :reason, true
  end
end
