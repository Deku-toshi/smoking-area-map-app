class Photo < ApplicationRecord
  belongs_to :smoking_area
  has_one_attached :image
  has_many :reports, as: :targetable

  validates :image, presence: true
  validate :image_type
  validate :image_size

  private

  def image_type
    return unless image.attached?
    unless image.content_type.in?(%w[image/jpeg image/png image/webp])
      errors.add(:image, "はJPEG、PNG、またはWEBP形式のみアップロードできます")
    end
  end

  def image_size
    return unless image.attached?
    if image.blob.byte_size > 5.megabytes
      errors.add(:image, "のサイズは5MB以下にしてください")
    end
  end
end
