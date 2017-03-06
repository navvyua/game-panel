class User < ApplicationRecord
  has_many :accounts, dependent: :delete_all
  has_many :news
  has_many :characters, dependent: :delete_all

  validates :email, presence: true, uniqueness: true
  validates :name,  presence: true

  has_secure_password
  acts_as_paranoid

  enum role: [:user, :helper, :admin]

  mount_uploader :avatar, AvatarUploader
end
