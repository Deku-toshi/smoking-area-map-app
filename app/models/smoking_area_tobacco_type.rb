class SmokingAreaTobaccoType < ApplicationRecord
  belongs_to :smoking_area
  belongs_to :tobacco_type

  validates :smoking_area_id, presence: true
  validates :tobacco_type_id, presence: true
end
