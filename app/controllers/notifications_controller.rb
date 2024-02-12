class NotificationsController < ApplicationController
  def index
    @notifications = Current.user.notifications.includes(event: :record).order('created_at DESC').collect
    @is_search_bar = true
  end

  # def delete; end
end
