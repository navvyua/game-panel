class RequestPolicy
  attr_reader :user, :request

  def initialize(user, request)
    @user = user
    @request = request
  end

  def index?
    user_owner_or_admin_only
  end

  def show?
    user_owner_only || user_processing_admin_only
  end

  def new?
    user_owner_only
  end

  def create?
    user_owner_only
  end

  def destroy?
    user_owner_or_admin_only
  end

  private

  def user_owner_only
    @user == @request.user
  end

  def user_owner_or_admin_only
    user_owner_only || @user.admin?
  end

  def user_processing_admin_only
    @user == @request.admin
  end
end
