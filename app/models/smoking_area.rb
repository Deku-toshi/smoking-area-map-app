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

  validates :is_indoor, inclusion: { in: [true, false] }, allow_nil: true

  before_validation :normalize_tobacco_types 
  validate :must_have_tobacco_types

  private

  def normalize_tobacco_types
    paper      = TobaccoType.find_by(name: "紙タバコ")
    electronic = TobaccoType.find_by(name: "電子タバコ")
    return unless paper && electronic

    if tobacco_type_ids.blank?
      self.tobacco_type_ids = [paper.id, electronic.id]
    elsif tobacco_type_ids.include?(paper.id) && !tobacco_type_ids.include?(electronic.id)
      self.tobacco_type_ids = (tobacco_type_ids + [electronic.id]).uniq
    end
  end

  def must_have_tobacco_types
    errors.add(:tobacco_types, "は1つ以上必要です") if tobacco_types.blank?
  end
end
