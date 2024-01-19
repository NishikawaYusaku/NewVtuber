class Vtuber < ApplicationRecord

  mount_uploader :image, ImageUploader
  
  has_many :vtuber_users
  has_many :users, through: :vtuber_users

  has_many :vtuber_places
  has_many :places, through: :vtuber_places

  has_many :vtuber_contents
  has_many :contents, through: :vtuber_contents

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  validates :name, uniqueness: true, presence: true
  # validates :name_x, uniqueness: true, if: -> { new_record? || changes[:name_x] }

end
