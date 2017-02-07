class AdminController < ApplicationController
  before_action :authenticated_only
  before_action :admin_only

  private

  def admin_only
    redirect_back(fallback_location: root_path) unless current_user.admin?
  end
end
