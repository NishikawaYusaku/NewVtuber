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
    params[:q] ||= {}
    @q = Vtuber.ransack(params[:q])
    if params[:tag]
      @results = Vtuber.joins(:tags).where(tags: { name: params[:tag] })
      @q_name = params[:tag]
    else
      params[:q].delete(:birthday_month_eq) if params[:q][:birthday_month_eq].blank?
      params[:q].delete(:birthday_day_eq) if params[:q][:birthday_day_eq].blank?
      params[:q].delete(:debut_date_year_eq) if params[:q][:debut_date_year_eq].blank?
      params[:q].delete(:debut_date_month_eq) if params[:q][:debut_date_month_eq].blank?
      params[:q].delete(:debut_date_day_eq) if params[:q][:debut_date_day_eq].blank?
      params[:q].delete(:favorites_count_gteq) if params[:q][:favorites_count_gteq].blank?
      params[:q].delete(:favorites_count_lteq) if params[:q][:favorites_count_lteq].blank?
      @results = @q.result(distinct: true)
      @q_name = params[:q].values[0] if params[:q].values[0] != "" && params[:q][:filtering_search].blank?
      @filtering_search = params[:q][:filtering_search] if params[:q].keys[0] != "filtering_search"
    end
    @vtubers = @results.order(:id).page(params[:page]).per(20)
  end

  def check_notification
    @notification_check = current_user.passive_notifications.where(checked: false)
  end
end
