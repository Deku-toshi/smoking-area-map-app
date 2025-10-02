class SmokingArea < ApplicationRecord
  belongs_to :user
  belongs_to :smoking_area_status
  belongs_to :smoking_area_type

  has_many :photos, dependent: :destroy
  has_many :comments
  has_many :smoking_area_tobacco_types
  has_many :tobacco_types, through: :smoking_area_tobacco_types

  validates :name, presence: true, length: {maximum: 100}
  validates :address, length: {maximum: 255}
  validates :detail, length: {maximum: 2000}, allow_blank: true

  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  enum available_time_type: {
    always: "24時間",
    business: "営業時間内"
  }, _prefix: :available_time

  validates :available_time_type, inclusion: {in: available_time_types.keys}, allow_nil: true

  validates :is_indoor, inclusion: {in: [true, false]}, allow_nil: true
  
  before_validation :nilify_blank_available_time_type

  # business 以外に切替時は UX のために自動で時間をクリア
  before_validation :clear_times_unless_business

  validate :validate_business_hours, if: -> { available_time_business? }

  private

  def nilify_blank_available_time_type
    self.available_time_type = nil if available_time_type.blank?
  end

  def clear_times_unless_business
    return if available_time_business?
    self.available_time_start = nil
    self.available_time_end   = nil
  end

  def validate_business_hours
    start_time = available_time_start
    end_time   = available_time_end

    if start_time.blank? || end_time.blank?
      errors.add(:base, "営業時間タイプが「営業時間内」の場合、開始・終了時刻は必須です")
      return
    end

    if start_time == end_time
      errors.add(:available_time_start, "と終了時間が同一です（開始と終了は異なる必要があります）")
    end
  end
end