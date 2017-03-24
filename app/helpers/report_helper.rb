module ReportHelper
  def reports_count
    Report.all.count
  end
end
