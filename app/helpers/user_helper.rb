module UserHelper
  def current_user_admin?
    current_user && current_user.admin?
  end

  def format_user_data(field)
    field ? field : '-'
  end
end
