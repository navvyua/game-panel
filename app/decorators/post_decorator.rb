class PostDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def slice_text
    h.truncate object.text, length: 499
  end

  def created_label
    h.t 'post.index.posted', time: created_at, author: author
  end

  private

  def author
    object.user.name
  end

  def created_at
    h.format_timestamp object.created_at
  end
end
