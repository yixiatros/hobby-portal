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

  def create_private
    @parts = []
    @parts << Current.user if Current.user
    Current.user.followers.each do |u|
      u_username = u.username
      if params[u_username] == '1'
        get_user = User.find_by(id: u.id)
        @parts << get_user if get_user
      end
    end

    get_name(@parts)
    @room = Room.create_private_room(@parts, @room_name)

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
    @room_name = @single_room.name

    @posts = Post.all
    @post = Post.new

    render 'home/index'
  end

  private

  def get_name(users)
    users = users.sort
    @room_name = 'private_'

    users.each do |u|
      @room_name = "#{@room_name}_#{u.id}"
    end
  end
end
