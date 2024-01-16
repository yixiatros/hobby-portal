# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @post = Post.new
    return unless session[:user_id]

    @user = User.find_by(id: session[:user_id])
  end
end
