module ApplicationHelper
  def format_timestamp(date)
    date.strftime('%R %d-%m-%y')
  end
end
