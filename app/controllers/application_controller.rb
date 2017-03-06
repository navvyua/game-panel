class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  helper_method :current_user

  def current_user
    @current_user = session[:user_id] ? User.find(session[:user_id]).decorate : NoUser.new
  end

  def authenticated_only
    redirect_to sign_in_path unless current_user.valid?
  end

  def unauthenticated_only
    redirect_back(fallback_location: profile_user_path(current_user)) if current_user.valid?
  end

  def authenticate_admin_user!
    redirect_to news_index_path unless current_user.admin?
  end
end
