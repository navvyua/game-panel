class Comment < ApplicationRecord
  belongs_to :request
  belongs_to :user

  validates :text, presence: true
end
