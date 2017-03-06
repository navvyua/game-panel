class Request < ApplicationRecord
  belongs_to :admin, class_name: 'User', required: false
  belongs_to :user

  has_many :comments

  validates :description, presence: true

  scope :available, -> { where(admin: nil) }
end
