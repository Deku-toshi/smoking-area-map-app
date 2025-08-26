class SmokingAreaType < ApplicationRecord
    has_many :smoking_areas

    validates :name, presence: true, length: {maximum: 30}
    validates :code, presence: true, length: {maximum: 50}, uniqueness: true
    validates :icon, presence: true, length: {maximum: 255}
    validates :color, presence: true, format: { with: /\A#[0-9A-Fa-f]{6}\z/ }
end
