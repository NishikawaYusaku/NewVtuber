class Vtuber < ApplicationRecord
  mount_uploader :image, ImageUploader

  ransacker :birthday_month, type: :integer do
    Arel.sql("EXTRACT(MONTH FROM birthday)::integer")
  end

  ransacker :birthday_day, type: :integer do
    Arel.sql("EXTRACT(DAY FROM birthday)::integer")
  end

  def self.ransackable_attributes(auth_object = nil)
    (super + ["birthday_month", "birthday_day"])
  rescue NoMethodError
    ["name", "affiliation", "gender", "birthday", "like", "unlike", "birthday_month", "birthday_day"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["contents", "places", "tags"]
  end

  has_many :vtuber_users, dependent: :destroy
  has_many :users, through: :vtuber_users

  has_many :vtuber_places, dependent: :destroy
  has_many :places, through: :vtuber_places

  has_many :vtuber_contents, dependent: :destroy
  has_many :contents, through: :vtuber_contents

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  has_many :vtuber_tags, dependent: :destroy
  has_many :tags, through: :vtuber_tags

  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  has_many :notifications, dependent: :destroy

  has_one :vtuber_youtube, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :name_x, uniqueness: true, if: -> { new_record? || changes[:name_x] }, allow_blank: true

  accepts_nested_attributes_for :vtuber_places, allow_destroy: true

  def save_tags(tags)
    tags.delete("")

    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(name: old_tag)
    end

    new_tags.each do |new_tag|
      vtuber_tag = Tag.find_or_create_by(name: new_tag)
      self.tags << vtuber_tag unless self.tags.exists?(vtuber_tag.id)
    end
  end

  def get_youtube_channel_id(url)
    youtube = youtube_data_api
    begin
      if url.include?("@")
        youtube_handle = url[(url.index("@") + 1)..]
        if youtube_handle.include?("?")
          youtube_handle = youtube_handle[0...youtube_handle.index("?")]
        elsif youtube_handle.include?("/")
          youtube_handle = youtube_handle[0...youtube_handle.index("/")]
        end

        youtube_handle_to_id = youtube.list_channels("statistics", for_handle: youtube_handle).to_h
        return if youtube_handle_to_id[:items].blank?

        youtube_channel_id = youtube_handle_to_id[:items][0][:id]
      elsif url.include?("/UC")
        youtube_channel_id = url[(url.index("/UC") + 1)..]
        youtube_channel_id_digits = 24
        return if youtube_channel_id.length != youtube_channel_id_digits
      else
        return
      end

      youtube_channel_id
    rescue Google::Apis::Error, StandardError
      nil
    end
  end

  def save_youtube_information(vtuber_id, youtube_channel_id)
    youtube = youtube_data_api
    begin
      youtube_channel = youtube.list_channels("statistics", id: youtube_channel_id).to_h
      return if youtube_channel[:items].blank?

      subscriber_count = youtube_channel[:items][0][:statistics][:subscriber_count]
      video_count = youtube_channel[:items][0][:statistics][:video_count]

      youtube_video = youtube.list_searches("snippet", channel_id: youtube_channel_id, type: 'video', max_results: 1, order: :date).to_h
      if youtube_video[:items]&.any?
        latest_video_id = youtube_video[:items][0][:id][:video_id]
        latest_video_title = youtube_video[:items][0][:snippet][:title]
      else
        latest_video_id = nil
        latest_video_title = nil
      end

      record = VtuberYoutube.find_or_initialize_by(vtuber_id: vtuber_id)
      record.update!(
        channel_id: youtube_channel_id,
        subscriber_count: subscriber_count,
        video_count: video_count,
        latest_video_id: latest_video_id,
        latest_video_title: latest_video_title
      )
    rescue Google::Apis::Error, StandardError
      nil
    end
  end

  def get_profile_icon_from_youtube(vtuber, youtube_channel_id)
    youtube_channel = youtube_data_api.list_channels("snippet", id: youtube_channel_id).to_h
    vtuber.remote_image_url = youtube_channel[:items][0][:snippet][:thumbnails][:high][:url]
    vtuber.save
    vtuber.reload
  end

  def notification_update(current_user)
    temp_ids = Favorite.select(:user_id).where(vtuber_id: id)
    if temp_ids.present?
      temp_ids.each do |temp_id|
        notification = current_user.active_notifications.new(
          visited_id: temp_id['user_id'],
          vtuber_id: id,
          action: "update"
        )
        notification.checked = true if notification.visitor_id == notification.visited_id
        notification.save if notification.valid?
      end
    end
  end

  private

  def youtube_data_api
    require 'google/apis/youtube_v3'
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV.fetch('GOOGLE_API_KEY', nil)
    youtube
  end
end
