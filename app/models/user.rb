class User < ApplicationRecord
  has_secure_password

  has_many :accounts, dependent: :delete_all

  validates_presence_of :email
  validates :email, uniqueness: true
end
