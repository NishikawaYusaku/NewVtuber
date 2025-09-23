namespace :vtuber_youtube do
  desc "VTuberのYouTube統計情報を定期的に更新"
  task update: :environment do
    require 'google/apis/youtube_v3'
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = ENV.fetch('GOOGLE_API_KEY', nil)

    VtuberYoutube.pluck(:channel_id).each do |channel_id|
      sleep 1
      begin
        record = VtuberYoutube.find_by(channel_id: channel_id)
        next unless record

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
      rescue Google::Apis::Error, StandardError
        puts "#{Time.current.strftime('%Y-%m-%d %H:%M:%S')}：[エラー]#{channel_id}"
        next
      end
    end

    puts "#{Time.current.strftime('%Y-%m-%d %H:%M:%S')}：[完了]VTuberのYouTube統計情報の定期更新"
  end
end
