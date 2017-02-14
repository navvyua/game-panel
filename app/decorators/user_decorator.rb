class UserDecorator < Draper::Decorator
  delegate_all

  def format_data(field)
    object.send(field) ? object.send(field) : '-'
  end
end
