class Message < ApplicationRecord
  before_create :confirm_participant

  belongs_to :user
  belongs_to :room

  has_many :notification_mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  after_create_commit { broadcast_append_to room }

  def confirm_participant
    return unless room.is_private

    is_participant = Participant.where(user_id: user.id, room_id: room.id).first
    throw :abort unless is_participant
  end
end
