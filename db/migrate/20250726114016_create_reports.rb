class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true

      # これは後に削除され、polymorphicなtargetableに置き換えられました（2025-07-27）
      t.references :photo, null: false, foreign_key: true

      t.references :report_status, null: false, foreign_key: true
      t.string :target_type  # 使用されていない。後にtargetable_typeに置き換えられた。
      t.text :reason

      t.timestamps
    end
  end
end
