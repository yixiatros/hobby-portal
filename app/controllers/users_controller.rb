# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @rooms = Room.public_rooms
    @users = Current.user.followers
    @room = Room.new
    @message = Message.new
    @room_name = get_name(@user, Current.user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, Current.user], @room_name)
    @messages = @single_room.messages

    @posts = Post.all
    @post = Post.new

    # @user = User.find_by(id: session[:user_id]) if session[:user_id]

    render 'home/index'
  end

  private

  def get_name(user1, user2)
    users = [user1, user2].sort
    "private_#{users[0].id}_#{users[1].id}"
  end
end
