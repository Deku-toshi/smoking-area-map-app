class RemoveDuplicatesAndAddUniqueConstraintToStatusNames < ActiveRecord::Migration[7.1]
  def up
    #report_statusesの重複処理
    execute <<~SQL
      WITH reps AS (
        SELECT name, MIN(id) AS keep_id, ARRAY_AGG(id) AS ids
        FROM report_statuses
        GROUP BY name
      )
      UPDATE reports r
      SET report_status_id = reps.keep_id
      FROM reps
      WHERE r.report_status_id = ANY(reps.ids)
        AND r.report_status_id <> reps.keep_id;
    SQL

    execute <<~SQL
      DELETE FROM report_statuses rs
      USING (
        SELECT id,
               ROW_NUMBER() OVER (PARTITION BY name ORDER BY id) AS rn
        FROM report_statuses
      ) d
      WHERE d.rn > 1
        AND rs.id = d.id;
    SQL

    add_index :report_statuses, :name, unique: true unless index_exists?(:report_statuses, :name, unique: true)

    #smoking_area_statusesの重複処理
    execute <<~SQL
      WITH reps AS (
        SELECT name, MIN(id) AS keep_id, ARRAY_AGG(id) AS ids
        FROM smoking_area_statuses
        GROUP BY name
      )
      UPDATE smoking_areas sa
      SET smoking_area_status_id = reps.keep_id
      FROM reps
      WHERE sa.smoking_area_status_id = ANY(reps.ids)
        AND sa.smoking_area_status_id <> reps.keep_id;
    SQL

    execute <<~SQL
      DELETE FROM smoking_area_statuses s
      USING (
        SELECT id,
               ROW_NUMBER() OVER (PARTITION BY name ORDER BY id) AS rn
        FROM smoking_area_statuses
      ) d
      WHERE d.rn > 1
        AND s.id = d.id;
    SQL

    add_index :smoking_area_statuses, :name, unique: true unless index_exists?(:smoking_area_statuses, :name, unique: true)
  end

  def down
    remove_index :smoking_area_statuses, :name if index_exists?(:smoking_area_statuses, :name)
    remove_index :report_statuses, :name if index_exists?(:report_statuses, :name)
  end
end
