class VtuberYoutube < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    ["subscriber_count", "video_count"]
  end

  belongs_to :vtuber

  validates :channel_id, uniqueness: true
end
