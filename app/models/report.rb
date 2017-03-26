class Report < ApplicationRecord
  belongs_to :character
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :delete_all

  mount_uploaders :images, ReportImageUploader

  validates_presence_of :description, :character_id
end
