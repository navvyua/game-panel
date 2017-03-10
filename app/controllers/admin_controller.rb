class AdminController < ApplicationController
  before_action :authenticated_only
  before_action :authorize_user

  private

  def authorize_user
    authorize [:admin, controller_name.classify.constantize]
  end
end
