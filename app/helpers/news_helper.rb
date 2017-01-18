module NewsHelper
  def slice_news_text(text)
    truncate(text, length: 499)
  end

  def news_date_format(date)
    date.strftime('%R %d-%m-%y')
  end
end
