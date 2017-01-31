module NewsHelper
  def slice_news_text(text)
    truncate(text, length: 499)
  end

  def news_created_label(news)
    "Posted at #{news.created_at.strftime('%R %d-%m-%y')} by #{news.user.name}"
  end
end
