class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :text, presence: true

  after_create_commit { RenderCommentJob.perform_later self }
end
