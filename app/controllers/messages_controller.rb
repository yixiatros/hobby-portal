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
    # users_in_room = @message.joined_users

    notification = MessageNotifier.with(message: @message.content, chatroom: @message.room, type: 'message')

    notification.deliver(Current.user)

    # users_in_room.each do |user|
    #   next if user.eql?(current_user)

    #   notification = MessageNotifier.with(message: @message.content, chatroom: @message.room, type: 'message')

    #   notification.deliver(user)
    # end
  end
end
