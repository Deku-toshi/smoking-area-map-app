class AddTargetableToReports < ActiveRecord::Migration[7.1]
  def change
    add_reference :reports, :targetable, polymorphic: true, null: false
    add_index :reports, [:targetable_type, :targetable_id]
  end
end
