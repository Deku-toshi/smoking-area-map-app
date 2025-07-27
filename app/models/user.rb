class User < ApplicationRecord
    has_secure_password

    has_many :smoking_areas

    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, length: {minimum: 6}, if: -> { password.present?}

    # validates :password, confirmation: true  フォーム実装時に追加

    before_save {self.email = email.downcase}
end