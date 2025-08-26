class SmokingAreaStatus < ApplicationRecord
    has_many :smoking_areas

    validates :name, presence: true, length: {maximum: 30}, uniqueness: true
end
