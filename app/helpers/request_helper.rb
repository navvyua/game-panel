module RequestHelper
  def available_requests_count
    Request.available.count
  end
end
