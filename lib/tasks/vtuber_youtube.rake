namespace :vtuber_youtube do
  desc "VTuberのYouTube統計情報を定期的に更新"
  task update: :environment do
    require 'google/apis/youtube_v3'
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV.fetch('GOOGLE_API_KEY', nil)

    error_channels = []

    VtuberYoutube.find_each do |record|
      channel_id = record.channel_id
      next unless channel_id

      begin
        youtube_channel = youtube.list_channels("statistics", id: channel_id).to_h
        next if youtube_channel[:items].blank?

        subscriber_count = youtube_channel[:items][0][:statistics][:subscriber_count]
        video_count = youtube_channel[:items][0][:statistics][:video_count]

        youtube_video = youtube.list_searches("snippet", channel_id: channel_id, type: 'video', max_results: 1, order: :date).to_h
        if youtube_video[:items]&.any?
          latest_video_id = youtube_video[:items][0][:id][:video_id]
          latest_video_title = youtube_video[:items][0][:snippet][:title]
        else
          latest_video_id = nil
          latest_video_title = nil
        end

        record.update!(
          subscriber_count: subscriber_count,
          video_count: video_count,
          latest_video_id: latest_video_id,
          latest_video_title: latest_video_title
        )

        sleep 1
      rescue Google::Apis::Error, StandardError => e
        Rails.logger.error "#{Time.current}：[エラー]#{channel_id} #{e.class} #{e.message}"
        error_channels << { channel_id: channel_id, error: "#{e.class}：#{e.message}" }
        next
      end
    end

    if error_channels.any?
      SystemMailer.youtube_fetch_failed(error_channels).deliver_now
    end

    Rails.logger.info "#{Time.current}：[完了]VTuberのYouTube統計情報の定期更新（エラー件数：#{error_channels.size}）"
  end
end
