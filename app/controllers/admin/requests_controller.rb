class Admin::RequestsController < AdminController
  before_action :set_current_request, except: :index

  def index
    @requests = Request.available.includes(:user).page(params[:page]).per(50)
    @processing_requests = @current_user.processing_requests.includes(:user)
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

  def set_current_request
    @request = Request.find(params[:id])
  end
end
