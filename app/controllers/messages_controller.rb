# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @message = Current.user.messages.create(content: msg_params[:content], room_id: params[:room_id])

    redirect_back fallback_location: root_path
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end
end
