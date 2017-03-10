class Admin::RequestsController < AdminController
  before_action :current_request, except: :index

  def index
    requests
    processing_requests
  end

  def update
    @request.update(admin_id: params[:admin])
    redirect_to [@request.user, @request]
  end

  def destroy
    @request.destroy
    redirect_to admin_requests_path
  end

  private

  def current_request
    @request = Request.find(params[:id])
  end

  def requests
    @requests = Request.available.includes(:user).page(params[:page]).per(50)
  end

  def processing_requests
    @processing_requests = @current_user.processing_requests.includes(:user)
  end
end
