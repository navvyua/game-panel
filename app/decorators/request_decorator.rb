class RequestDecorator < Draper::Decorator
  delegate_all

  def label
    "#{object.class} ##{object.id}"
  end

  def status_label
    object.closed? ? 'Resolved' : 'Processing'
  end
end
