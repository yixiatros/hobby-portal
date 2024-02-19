class Room < ApplicationRecord
  has_many :messages
  has_many :participants, dependent: :destroy

  validates_uniqueness_of :name

  scope :public_rooms, -> { where(is_private: false) }

  # after_create_commit { broadcast_append_to 'rooms' }
  # after_create_commit { broadcast_if_public }

  def broadcast_if_public
    broadcast_append_to 'rooms' unless is_private
  end

  def self.create_private_room(users, room_name)
    single_room = Room.create(name: room_name, is_private: true)
    users.each do |user|
      Participant.create(user_id: user.id, room_id: single_room.id)
    end
    single_room
  end

  def self.get_all_groups_of_user(user)
    @all_rooms = Room.joins(:participants).where(participants: { user_id: user.id }).select('rooms.*')
    @group_rooms = []
    @all_rooms.each do |r|
      @part = Participant.where(room_id: r.id).count
      @group_rooms << r if @part > 2
    end
    @group_rooms
  end
end
