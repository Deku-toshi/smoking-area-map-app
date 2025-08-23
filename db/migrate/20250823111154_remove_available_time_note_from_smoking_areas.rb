class RemoveAvailableTimeNoteFromSmokingAreas < ActiveRecord::Migration[7.1]
  def up
    if column_exists?(:smoking_areas, :available_time_note)
      remove_column :smoking_areas, :available_time_note, :string
    end  
  end

  def down
    add_column :smoking_areas, :available_time_note, :string, if_not_exists: true
  end
end
