class RequestsController < ApplicationController
  before_action :current_resource_owner
  before_action :current_resource, only: [:show, :destroy]

  def index
    authorize @owner_user.requests.new
    @requests = @owner_user.requests.includes(:user).page(params[:page]).decorate
  end

  def show
    authorize @request
  end

  def new
    @request = @owner_user.requests.new
    authorize @request
  end

  def create
    @request = @owner_user.requests.new(request_params)
    authorize @request

    if @request.save
      redirect_to [@owner_user, @request], notice: t('.request_created')
    else
      flash.now[:alert] = t('.incorrect_info')
      render :new
    end
  end

  def destroy
    authorize @request
    @request.destroy
    redirect_to user_requests_path @owner_user
  end

  private

  def request_params
    params.require(:request).permit(:description)
  end

  def current_resource_owner
    @owner_user = User.find(params[:user_id]).decorate
  end

  def current_resource
    @request = @owner_user.requests.find(params[:id]).decorate
  end
end
