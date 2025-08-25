class User < ApplicationRecord
    has_secure_password

    has_many :smoking_areas
    has_many :comments

    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 255}, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: {case_sensitive: false}
    validates :password, length: {minimum: 6}, allow_nil: true

    # validates :password, confirmation: true  フォーム実装時に追加
end