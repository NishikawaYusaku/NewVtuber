class Vtuber < ApplicationRecord
  mount_uploader :image, ImageUploader

  def self.ransackable_attributes(_auth_object = nil)
    ["name", "affiliation", "gender", "like", "unlike"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ["contents", "places", "tags"]
  end

  has_many :vtuber_users, dependent: :destroy
  has_many :users, through: :vtuber_users

  has_many :vtuber_places, dependent: :destroy
  has_many :places, through: :vtuber_places

  has_many :vtuber_contents, dependent: :destroy
  has_many :contents, through: :vtuber_contents

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  has_many :vtuber_tags, dependent: :destroy
  has_many :tags, through: :vtuber_tags

  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  has_many :notifications, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :name_x, uniqueness: true, if: -> { new_record? || changes[:name_x] }, allow_blank: true

  accepts_nested_attributes_for :vtuber_places, allow_destroy: true

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(name: old_tag)
    end

    new_tags.each do |new_tag|
      vtuber_tag = Tag.find_or_create_by(name: new_tag)
      self.tags << vtuber_tag unless self.tags.exists?(vtuber_tag.id)
    end
  end

  def notification_update(current_user)
    temp_ids = Favorite.select(:user_id).where(vtuber_id: id)
    if temp_ids.present?
      temp_ids.each do |temp_id|
        notification = current_user.active_notifications.new(
          visited_id: temp_id['user_id'],
          vtuber_id: id,
          action: "update"
        )
        notification.checked = true if notification.visitor_id == notification.visited_id
        notification.save if notification.valid?
      end
    end
  end
end
