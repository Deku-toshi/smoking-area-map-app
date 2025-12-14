class SmokingArea < ApplicationRecord
  has_many :smoking_area_tobacco_types, dependent: :destroy
  has_many :tobacco_types, -> { order(:display_order) }, through: :smoking_area_tobacco_types

  validates :name,    presence: true, length:  { maximum: 100 }
  validates :address, length: { maximum: 255 }
  validates :detail,  length: { maximum: 2000 }

  validates :latitude, 
             presence: true, 
             numericality: { greater_than_or_equal_to: -90, 
                             less_than_or_equal_to: 90 }
                             
  validates :longitude, 
             presence: true, 
             numericality: { greater_than_or_equal_to: -180, 
                             less_than_or_equal_to: 180 }

  validates :is_indoor, inclusion: {in: [true, false]}, allow_nil: true
end
