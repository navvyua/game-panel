class News < ApplicationRecord
  PER_PAGE = 10

  paginates_per PER_PAGE

  belongs_to :user

  validates :title, presence: true, length: { minimum: 10 }
  validates :text, presence: true, length: { minimum: 500 }

  mount_uploader :news_image, NewsImageUploader
end
