class VtuberPlace < ApplicationRecord
  belongs_to :vtuber
  belongs_to :place

  validates :url, uniqueness: true, presence: true, inclusion: {in: ['https://'], message: "は「https://」から入力してください"}
end
