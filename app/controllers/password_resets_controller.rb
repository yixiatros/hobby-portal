# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # Send email
      PasswordMailer.with(user: @user).reset.deliver_later
    end

    redirect_to log_in_path, notice: 'Check your email form a password reset link'
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to log_in_path, alert: 'Your token has expired.'
  end

  def update
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
    if @user.update(password_params)
      redirect_to log_in_path, notice: 'Your password was reset successfully'
    else
      render :edit
    end
  end

  def password_params
    params.require([:user]).permit(:password, :password_confirmation)
  end
end
