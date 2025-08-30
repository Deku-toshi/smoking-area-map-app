class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :smoking_area

  has_many :reports, as: :targetable

  validates :content, presence: true, length: {maximum: 1000}
end
