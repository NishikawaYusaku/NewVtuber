class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).where(created_at: 7.days.ago..).page(params[:page]).per(10)
    render 'index'
  end

  def mark_as_read
    current_user.passive_notifications.where(checked: false).update_all(checked: true, updated_at: Time.current)
    head :ok
  end
end
