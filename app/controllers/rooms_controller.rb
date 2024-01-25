# frozen_string_literal: true

class RoomsController < ApplicationController
  def index
    redirect_to sign_up_path unless Current.user
    @rooms = Room.public_rooms
    @users = Current.user.followers
  end

  def create
    @room = Room.create!(name: params['name'])

    if @room.save
      redirect_to rooms_path, notice: 'Room created.'
    else
      redirect_to root_path, alert: 'Something went wrong, the room was not created.'
    end
  end

  def show
    @single_room = Room.find(params[:id])
    @rooms = Room.public_rooms
    @users = Current.user.followers
    @room = Room.new
    @message = Message.new
    @messages = @single_room.messages

    render :index
  end
end
