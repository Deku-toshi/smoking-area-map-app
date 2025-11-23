class SmokingAreaTobaccoType < ApplicationRecord
  belongs_to :smoking_area
  belongs_to :tobacco_type

  validates :tobacco_type_id, uniqueness: { scope: :smoking_area_id }
end
