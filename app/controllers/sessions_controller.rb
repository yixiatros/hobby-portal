# frozen_string_literal: true

class SessionsController < ApplicationController
  def login
    if logged_in?
      redirect_to root_path
    end
  end

  def create
    user = User.find_by(email: params[:email])

    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully'
    else
      # flash[:alert] = "Invalid email or password"
      redirect_to log_in_path, alert: 'Invalid email or password'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out'
  end

  def omniauth
    @user = User.find_or_create_by(uid: request.env['omniauth.auth']['uid'],
                                   provider: request.env['omniauth.auth']['provider']) do |user|
      user.username = request.env['omniauth.auth']['info']['name']
      user.email = request.env['omniauth.auth']['info']['email']
      user.password = SecureRandom.hex(10)
    end

    if @user.valid?
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :login
    end
  end
end
