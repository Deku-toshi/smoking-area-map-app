class ReportStatus < ApplicationRecord
    has_many :reports

    validates :name, presence: true, length: {maximum: 30}, uniqueness: true
end
