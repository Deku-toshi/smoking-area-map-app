class TobaccoType < ApplicationRecord
    has_many :smoking_area_tobacco_types
    has_many :smoking_areas, through: :smoking_area_tobacco_types
end
