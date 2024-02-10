# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @message = Current.user.messages.create(content: msg_params[:content], room_id: params[:room_id])

    notify_recipient

    redirect_back fallback_location: root_path
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end

  def notify_recipient
    participants_in_room = @message.room.participants

    participants_in_room.each do |participant|
      next if participant.user.eql?(Current.user)

      notification = MessageNotifier.with(message: @message.content, chatroom: @message.room, type: 'message')

      notification.deliver(participant.user)
    end
  end
end
