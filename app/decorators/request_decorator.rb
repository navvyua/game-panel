class RequestDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def label
    "#{object.class} ##{object.id}"
  end

  def status_label
    if object.closed?
      'Resolved'
    else
      object.admin ? "Processing by #{object.admin.name}" : 'Processing'
    end
  end
end
