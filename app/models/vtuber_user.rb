class VtuberUser < ApplicationRecord
  belongs_to :user
  belongs_to :vtuber
end
