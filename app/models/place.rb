class Place < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  has_many :vtuber_places
  has_many :vtubers, through: :vtuber_places
end
