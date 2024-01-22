# frozen_string_literal: true

class ContactsController < ApplicationController

  # Get /contacts
  def index
    @users = User.all
  end

  # Post /contacts/add
  def add
    user = User.find(params[:user_id])

    return unless user.present?

    @relationship = Relationship.create!(
      followee_id: Current.user.id,
      follower_id: user.id
    )

    if @relationship.save
      redirect_to root_path, notice: 'Contact saved.'
    else
      redirect_to root_path, alert: 'Something went wrong, the contact was not saved.'
    end
  end
end
