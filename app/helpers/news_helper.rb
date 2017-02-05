module NewsHelper
  def slice_news_text(text)
    truncate(text, length: 499)
  end

  def news_created_label(news)
    t('news.index.posted', time: created_at(news), author: author(news))
  end

  def author(news)
    news.user.name
  end

  def created_at(news)
    news.created_at.strftime('%R %d-%m-%y')
  end
end
