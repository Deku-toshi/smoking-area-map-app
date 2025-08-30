class SmokingArea < ApplicationRecord
  belongs_to :user
  belongs_to :smoking_area_status
  belongs_to :smoking_area_type

  has_many :photos
  has_many :comments
  has_many :smoking_area_tobacco_types
  has_many :tobacco_types, through: :smoking_area_tobacco_types

  validates :name, presence: true, length: {maximum: 100}
  validates :address, presence: true, length: {maximum: 255}
  validates :detail, length: {maximum: 2000}, allow_blank: true

  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  enum available_time_type: {
    always: "24時間",
    business: "営業時間内",
    unknown: "不明"
  }, _prefix: :available_time

  validates :available_time_type, inclusion: {in: available_time_types.keys}, allow_nil: true

  validates :is_indoor, inclusion: {in: [true, false]}, allow_nil: true
end