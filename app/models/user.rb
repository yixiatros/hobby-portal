class User < ApplicationRecord

  # encrypt password
  has_secure_password

  has_many :followed_users, foreign_key: :follower_id, class_name: "Relationship"
  has_many :followees, through: :followed_users, :dependent => :delete_all

  has_many :following_users, foreign_key: :followee_id, class_name: "Relationship"
  has_many :followers, through: :following_users, :dependent => :delete_all

  has_many :messages

  scope :all_except, ->(user) { where.not(id: user) }

  validates_presence_of :username, :password_digest
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address"}

  after_create_commit { broadcast_append_to 'users' }
end
