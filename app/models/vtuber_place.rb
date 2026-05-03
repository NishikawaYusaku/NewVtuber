class VtuberPlace < ApplicationRecord
  belongs_to :vtuber
  belongs_to :place

  validates :url, uniqueness: true, presence: true, format: { with: /\Ahttps:\/\//, message: "は「https://」から入力してください" }
end
