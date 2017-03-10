class Admin::CharacterPolicy
  attr_reader :user

  def initialize(user, _)
    @user = user
  end

  def index?
    helper_or_admin_only
  end

  def update?
    helper_or_admin_only
  end

  private

  def helper_or_admin_only
    user.helper_or_admin?
  end
end
