class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :vtuber

  validates :body, presence: true
end
