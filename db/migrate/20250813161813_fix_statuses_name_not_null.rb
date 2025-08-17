class FixStatusesNameNotNull < ActiveRecord::Migration[7.1]
  def up
    change_column_null :report_statuses, :name, false
    change_column_null :smoking_area_statuses, :name, false

    # unique index がなければ追加（重複登録を防ぐため）
    add_index :report_statuses, :name, unique: true unless index_exists?(:report_statuses, :name, unique: true)
    add_index :smoking_area_statuses, :name, unique: true unless index_exists?(:smoking_area_statuses, :name)
  end

  def down
    remove_index :report_statuses, :name if index_exists?(:report_statuses, :name)
    remove_index :smoking_area_statuses, :name if index_exists?(:smoking_area_statuses, :name)

    change_column_null :report_statuses, :name, true
    change_column_null :smoking_area_statuses, :name, true
  end
end
