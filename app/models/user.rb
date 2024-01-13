class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :vtuber_users
  has_many :vtubers, through: :vtuber_users

  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, presence: true, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  # validates :password_current, presence: true, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true
  validates :reset_password_token, uniqueness: true, allow_nil: true
end
