class BugTicket < ApplicationRecord
  paginates_per 10

  belongs_to :user

  validates :title,       presence: true
  validates :description, presence: true

  mount_uploader :bug_image, BugImageUploader

  enum status: %i(open in_progress closed)

  scope :all_open_count, -> { where(status: 0).count }
end
