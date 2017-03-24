class Admin::ReportsController < AdminController
  def index
    @reports = reports
  end

  def destroy
    report = Report.find params[:id]
    report.destroy

    redirect_to admin_reports_path
  end

  private

  def reports
    Report.all.reverse_order.includes(:user).page(params[:page]).per(50)
  end
end
