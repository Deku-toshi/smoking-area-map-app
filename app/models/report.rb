class Report < ApplicationRecord
  belongs_to :user
  belongs_to :report_status
  belongs_to :targetable, polymorphic: true

  ALLOWED_TARGETS = %w[Comment Photo].freeze

  validates :reason, presence: true, length: {maximum: 1000}
  validates :targetable_type, inclusion: {in: ALLOWED_TARGETS}
end
