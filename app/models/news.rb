class News < ApplicationRecord
  paginates_per 10

  belongs_to :user

  validates :title,      presence: true, length: { minimum: 10 }
  validates :text,       presence: true, length: { minimum: 10 }

  mount_uploader :news_image, NewsImageUploader
end
