class CommentsChannel < ApplicationCable::Channel
  def follow(params)
    stop_all_streams
    commentable = params['commentable_type'].constantize.find params['commentable_id']
    stream_for commentable
  end

  def unfollow
    stop_all_streams
  end
end
