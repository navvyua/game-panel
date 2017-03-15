class Admin::BugTicketsController < AdminController
  def index
    @bugs = bugs.decorate
  end

  private

  def bugs
    BugTicket.includes(:user).reverse_order.page(params[:page])
  end
end
