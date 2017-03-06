class CommentsController < ApplicationController
  before_action :current_resource_user
  before_action :current_resource_owner
  before_action :current_resource, only: :destroy

  def create
    @request.comments.create(comment_params)
    redirect_to [@user, @request]
  end

  def destroy
    @comment.destroy
    redirect_to user_requests_path @user
  end

  private

  def current_resource_user
    @user = User.find(params[:user_id])
  end

  def current_resource_owner
    @request = @user.requests.find(params[:request_id])
  end

  def current_resource
    @comment = @request.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text, :user_id)
  end
end
