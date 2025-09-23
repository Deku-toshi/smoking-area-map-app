class AddOnDeleteCascadeToCommentsOnSmokingAreaForeignKey < ActiveRecord::Migration[7.1]
  def up
    remove_foreign_key :comments, :smoking_areas if foreign_key_exists?(:comments, :smoking_areas)
    add_foreign_key :comments, :smoking_areas, on_delete: :cascade
  end

  def down
    remove_foreign_key :comments, :smoking_areas
    add_foreign_key :comments, :smoking_areas
  end
end
