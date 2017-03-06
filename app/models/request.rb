class Request < ApplicationRecord
  belongs_to :user
  belongs_to :admin, class_name: 'User', required: false

  has_many :comments

  validates :description, presence: true

  scope :available, -> { where(admin: nil) }
end
