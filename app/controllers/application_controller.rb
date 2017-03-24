class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  helper_method :current_user

  def current_user
    @current_user = session[:user_id] ? User.find(session[:user_id]).decorate : NoUser.new
  end

  def authenticated_only
    redirect_to sign_in_path unless current_user.valid?
  end

  def unauthenticated_only
    redirect_back(fallback_location: root_path) if current_user.valid?
  end

  def user_not_authorized
    flash[:alert] = t 'user_not_authorized'
    redirect_back fallback_location: root_path
  end

  def authenticate_admin_user!
    redirect_to posts_path unless current_user.admin?
  end
end
