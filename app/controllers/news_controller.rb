class NewsController < ApplicationController
  before_action :find_news, only: [:edit, :update, :show, :destroy]
  before_action :authenticated_only, except: :index

  def index
    @all_news = News.includes(:user).page(params[:page]).reverse_order.decorate
    @news = News.new
  end

  def create
    current_user.news.create!(news_params)
    redirect_to news_index_path, notice: t('.post_created')
  end

  def update
    redirect_to news_path(@news), notice: t('.post_updated') if @news.update!(news_params)
  end

  def destroy
    redirect_to news_index_path, notice: t('.post_destroyed') if @news.destroy!
  end

  private

  def news_params
    params.require(:news).permit(:title, :text, :news_image)
  end

  def find_news
    @news = News.find(params[:id]).decorate
  end
end
