class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :smoking_area

  validates :content, presence: true, length: {maximum: 1000}
end
