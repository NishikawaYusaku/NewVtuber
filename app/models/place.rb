class Place < ApplicationRecord
  has_many :vtuber_places
  has_many :vtubers, through: :vtuber_places
end
