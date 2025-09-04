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
    if params[:tag]
      @results = Vtuber.joins(:tags).where(tags: { name: params[:tag] })
      @q_name = params[:tag]
    else
      query = { name_or_affiliation_or_gender_or_like_or_unlike_or_contents_name_or_places_name_or_tags_name_cont: params[:q] }
      @results = Vtuber.ransack(query).result(distinct: true)
      @q_name = params[:q] unless params[:q].blank?
    end
    @vtubers = @results.order(:id).page(params[:page]).per(20)
  end

  def check_notification
    @notification_check = current_user.passive_notifications.where(checked: false)
  end
end
