module UserHelper
  def current_user_admin?
    current_user && current_user.admin?
  end
end
