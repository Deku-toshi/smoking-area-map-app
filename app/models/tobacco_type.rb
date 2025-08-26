class TobaccoType < ApplicationRecord
    has_many :smoking_area_tobacco_types
    has_many :smoking_areas, through: :smoking_area_tobacco_types

    validates :kinds, presence: true, length: {maximum: 30}, uniqueness: true
    validates :icon, presence: true, length: {maximum: 255}
end
