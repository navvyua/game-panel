class ReportDecorator < Draper::Decorator
  delegate_all

  def label
    "#{object.class} ##{object.id}"
  end
end
