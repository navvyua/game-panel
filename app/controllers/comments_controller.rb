class CommentsController < ApplicationController
  before_action :current_commentable

  def create
    @commentable.comments.create!(comment_params)
  end

  def destroy
    comment = @commentable.comments.find(params[:id])
    comment.destroy
    redirect_to [@commentable.user, @commentable]
  end

  private

  def current_commentable
    @commentable = if params[:request_id]
                     Request.find(params[:request_id])
                   elsif params[:report_id]
                     Report.find(params[:report_id])
                   end
  end

  def comment_params
    params.require(:comment).permit permitted_params
  end

  def permitted_params
    %i(
      text
      user_id
    )
  end
end
