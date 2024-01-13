class Content < ApplicationRecord
  has_many :vtuber_contents
  has_many :vtubers, through: :vtuber_contents
end
