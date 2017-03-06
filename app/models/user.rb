class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password

  has_many :accounts,   dependent: :delete_all
  has_many :characters, dependent: :delete_all
  has_many :comments,   dependent: :delete_all
  has_many :news
  has_many :processing_requests, class_name: 'Request'
  has_many :requests, dependent: :delete_all

  validates :email, presence: true, uniqueness: true
  validates :name,  presence: true

  enum role: [:user, :helper, :admin]

  mount_uploader :avatar, AvatarUploader

  def helper_or_admin?
    helper? || admin?
  end
end
