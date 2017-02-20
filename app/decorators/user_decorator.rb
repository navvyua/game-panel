class UserDecorator < Draper::Decorator
  delegate_all

  def format_data(field)
    object.send(field) ? object.send(field) : '-'
  end

  def name_with_role
    "#{object.name} #{object.role.capitalize}"
  end

  def created_label
    h.format_timestamp object.created_at
  end
end
