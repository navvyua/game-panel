class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password

  has_many :accounts, dependent: :delete_all
  has_many :bug_tickets
  has_many :characters, dependent: :delete_all
  has_many :posts
  has_many :processing_requests, class_name: 'Request', foreign_key: 'admin_id',
                                 dependent: :destroy
  has_many :reports
  has_many :received_reports, through: :characters, source: :reports
  has_many :requests, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name,  presence: true

  enum role: %i(user helper admin)

  mount_uploader :avatar, AvatarUploader

  def helper_or_admin?
    helper? || admin?
  end
end
