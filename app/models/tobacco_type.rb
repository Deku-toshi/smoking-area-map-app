class TobaccoType < ApplicationRecord
    has_many :smoking_area_tobacco_types, dependent: :destroy
    has_many :smoking_areas, through: :smoking_area_tobacco_types

    validates :name,          presence: true, length: {maximum: 30}, uniqueness: true
    validates :icon,          presence: true, length: {maximum: 255}
    validates :display_order, presence: true, uniqueness: true
end
