# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @message = Current.user.messages.create!(content: msg_params[:content], room_id: params[:room_id])

    redirect_to rooms_path, alert: 'Something went wrong. Could not send message.' unless @message.save
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end
end
