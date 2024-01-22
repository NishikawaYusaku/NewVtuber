class Content < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  has_many :vtuber_contents
  has_many :vtubers, through: :vtuber_contents
end
