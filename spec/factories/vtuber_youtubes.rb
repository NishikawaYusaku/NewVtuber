FactoryBot.define do
  factory :vtuber_youtube do
    association :vtuber
    subscriber_count { nil }
    video_count { nil }
    latest_video_id { nil }
    latest_video_title { nil }
    channel_id { "UCX7YkU9nEeaoZbkVLVajcMg" }
  end
end
