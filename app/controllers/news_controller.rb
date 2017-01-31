class NewsController < ApplicationController
  before_action :find_news, only: [:edit, :update, :show, :destroy]
  before_action :authenticated_only, except: :index

  def index
    @all_news = News.page(params[:page]).per(5).reverse_order
    @news = News.new
  end

  def create
    current_user.news.create!(news_params)
    redirect_to news_index_path
  end

  def edit; end

  def update
    redirect_to news_path(@news) if @news.update!(news_params)
  end

  def destroy
    redirect_to news_index_path if @news.destroy!
  end

  private

  def news_params
    params.require(:news).permit(:title, :text, :news_image)
  end

  def find_news
    @news = News.find(params[:id])
  end
end
