class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).where("read_at IS NULL OR read_at >= ?", 7.days.ago).order(created_at: :desc).page(params[:page]).per(10)
    render 'index'
  end

  def mark_as_read
    read_time = Time.current
    current_user.passive_notifications.where(read_at: nil).update_all(updated_at: read_time, read_at: read_time)
    head :ok
  end
end
