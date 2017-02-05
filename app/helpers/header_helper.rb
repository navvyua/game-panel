module HeaderHelper
  def current_user_name_label
    "#{current_user.name} - #{current_user.role}"
  end

  def current_user_created_label
    current_user.created_at.strftime('%d %b. %Y')
  end
end
