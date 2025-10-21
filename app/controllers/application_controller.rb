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
    params[:q] = change_variant_word(params[:q].values[0]) if params[:q][:normal_search].present?
    @q = Vtuber.ransack(params[:q])
    if params[:tag]
      @results = Vtuber.joins(:tags).where(tags: { name: params[:tag] })
      @q_name = params[:tag]
    else
      delete_blank_params
      @results = @q.result(distinct: true)
      @q_name = params[:q].values[0] if params[:q].values[0] != "" && params[:q][:filtering_search].blank?
      @filtering_search = params[:q][:filtering_search] if params[:q].keys[0] != "filtering_search"
    end
    @vtubers = @results.order(:id).page(params[:page]).per(20)
  end

  def change_variant_word(word)
    q_name = [
      word,
      Moji.zen_to_han(word),
      Moji.han_to_zen(word),
      Moji.kata_to_hira(word),
      Moji.hira_to_kata(word),
      Moji.upcase(word),
      Moji.downcase(word),
      Moji.kata_to_hira(Moji.han_to_zen(word)),
      Moji.zen_to_han(Moji.hira_to_kata(word))
    ].uniq
    { name_or_affiliation_or_gender_or_language_or_like_or_unlike_or_contents_name_or_places_name_or_tags_name_cont_any: q_name }
  end

  def delete_blank_params
    params[:q].delete(:places_name_eq) if params[:q][:places_name_eq].blank?
    params[:q].delete(:birthday_month_eq) if params[:q][:birthday_month_eq].blank?
    params[:q].delete(:birthday_day_eq) if params[:q][:birthday_day_eq].blank?
    params[:q].delete(:debut_date_year_eq) if params[:q][:debut_date_year_eq].blank?
    params[:q].delete(:debut_date_month_eq) if params[:q][:debut_date_month_eq].blank?
    params[:q].delete(:debut_date_day_eq) if params[:q][:debut_date_day_eq].blank?
    params[:q].delete(:favorites_count_gteq) if params[:q][:favorites_count_gteq].blank?
    params[:q].delete(:favorites_count_lteq) if params[:q][:favorites_count_lteq].blank?
    params[:q].delete(:vtuber_youtube_subscriber_count_gteq) if params[:q][:vtuber_youtube_subscriber_count_gteq].blank?
    params[:q].delete(:vtuber_youtube_subscriber_count_lteq) if params[:q][:vtuber_youtube_subscriber_count_lteq].blank?
    params[:q].delete(:vtuber_youtube_video_count_gteq) if params[:q][:vtuber_youtube_video_count_gteq].blank?
    params[:q].delete(:vtuber_youtube_video_count_lteq) if params[:q][:vtuber_youtube_video_count_lteq].blank?
  end

  def check_notification
    @notification_check = current_user.passive_notifications.where(checked: false)
  end
end
