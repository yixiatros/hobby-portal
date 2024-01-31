class NotificationsController < ApplicationController
  def index
    @notifications = Current.user.notifications.includes(event: :record)
  end
end
