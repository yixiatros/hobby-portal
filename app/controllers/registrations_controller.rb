class RegistrationsController < ApplicationController
  def register
    @user = User.new
  end

  def create
    @user = User.create!(user_params)
    if @user.save
      redirect_to root_path, notice: "Successfully created account"
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(
      :email,
      :username,
      :password,
      :password_confirmation
    )
  end
end
