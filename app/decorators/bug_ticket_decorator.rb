class BugTicketDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def created_label
    created_at
  end

  def status_color(status)
    color_hash = { 'success': 'open', 'info': 'in_progress', 'danger': 'closed' }
    color_hash.key(status).to_s
  end

  private

  def created_at
    h.format_timestamp object.created_at
  end
end
