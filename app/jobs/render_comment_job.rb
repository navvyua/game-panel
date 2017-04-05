class RenderCommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    commentable = comment.commentable_type.constantize.find comment.commentable_id
    CommentsChannel.broadcast_to commentable, render_comment(comment)
  end

  private

  def render_comment(comment)
    ApplicationController.renderer.render(partial: 'comments/comment', locals: { comment: comment })
  end
end
