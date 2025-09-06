class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login
  before_action :set_search
  before_action :check_notification, if: proc { logged_in? }

  private

  def not_authenticated
    redirect_to login_path, warning: "ログインしてください"
  end

  def set_search
    @q = Vtuber.ransack(params[:q])
    if params[:tag]
      @results = Vtuber.joins(:tags).where(tags: { name: params[:tag] })
      @q_name = params[:tag]
    else
      @results = @q.result(distinct: true)
      @q_name = params[:q].values[0] if params[:q].present? && params[:q].values[0].present? && params[:q][:filtering_search].blank?
      @filtering_search = params[:q][:filtering_search] if params[:q].present? && params[:q].keys.length > 1
    end
    @vtubers = @results.order(:id).page(params[:page]).per(20)
  end

  def check_notification
    @notification_check = current_user.passive_notifications.where(checked: false)
  end
end
