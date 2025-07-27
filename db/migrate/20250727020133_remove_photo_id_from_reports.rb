class RemovePhotoIdFromReports < ActiveRecord::Migration[7.1]
  def change
    remove_reference :reports, :photo, null: false, foreign_key: true
  end
end
