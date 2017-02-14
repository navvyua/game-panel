module ApplicationHelper
  def format_timestamp(date)
    date.strftime('%R %d-%m-%y')
  end

  def format_money(value)
    number_to_currency(value, delimiter: ' ', precision: 0)
  end
end
