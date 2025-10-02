class ChangeAddressNullOnSmokingAreas < ActiveRecord::Migration[7.1]
  def change
    change_column_null :smoking_areas, :address, true
  end
end