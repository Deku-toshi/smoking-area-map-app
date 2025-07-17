class CreateReportStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :report_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
