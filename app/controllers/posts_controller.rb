class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :destroy]
  before_action :authenticated_only, except: :index

  def index
    @all_posts = posts.decorate
    @post = Post.new
  end

  def create
    current_user.posts.create!(post_params)

    redirect_to posts_path, notice: t('.post_created')
  end

  def update
    @post.update!(post_params)

    redirect_to post_path(@post), notice: t('.post_updated')
  end

  def destroy
    @post.destroy!

    redirect_to posts_path, notice: t('.post_destroyed')
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :post_image)
  end

  def find_post
    @post = Post.find(params[:id]).decorate
  end

  def posts
    Post.includes(:user).reverse_order.page(params[:page])
  end
end
