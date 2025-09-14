class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :vtuber, counter_cache: true
end
