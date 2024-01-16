class User < ApplicationRecord
  # encrypt password
  has_secure_password

  validates_presence_of :username, :password_digest
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}
end
