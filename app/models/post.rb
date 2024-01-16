class Post < ApplicationRecord
  mount_uploader :attachment, AvatarUploader
  belongs_to :user
end
