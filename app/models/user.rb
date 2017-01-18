class User < ApplicationRecord
  has_secure_password

  has_many :accounts, dependent: :delete_all
  has_many :news

  validates :email, presence: true, uniqueness: true
  validates :name,  presence: true

  enum role: [:user, :helper, :admin]
end
