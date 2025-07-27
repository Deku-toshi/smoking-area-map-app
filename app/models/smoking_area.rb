class SmokingArea < ApplicationRecord
  belongs_to :user
  belongs_to :smoking_area_status
  belongs_to :smoking_area_type

  has_many :photos

  validates :name, presence: true, length: {maximum: 50}
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :address, presence: true, length: {maximum: 100}
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  validate :available_time_range_is_valid

  enum available_time_type: {
    always: "24時間",
    business: "営業時間内",
    unknown: "不明"
  }

  private

  def available_time_range_is_valid
    if available_time_start.present? && available_time_end.present?
      if available_time_start >= available_time_end
        errors.add(:available_time_start, "は終了時間より前である必要があります")
      end
    end
  end
end