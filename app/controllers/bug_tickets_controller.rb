class BugTicketsController < ApplicationController
  before_action :authenticated_only
  before_action :find_ticket, only: %i(edit update show destroy)

  def index
    @user_bug_tickets = bug_tickets.decorate
  end

  def new
    @bug_ticket = BugTicket.new
  end

  def create
    current_user.bug_tickets.create!(bug_tickets_params)

    redirect_to bug_tickets_path, notice: t('.ticket_created')
  end

  def update
    respond_to do |format|
      if @bug_ticket.update(bug_tickets_params)
        format.js
      else
        flash.now[:alert] = t('.not_updated')
      end
    end
  end

  def destroy
    @bug_ticket.destroy!

    redirect_to bug_tickets_path, notice: t('.ticket_destroyed')
  end

  private

  def bug_tickets_params
    params.require(:bug_ticket).permit(:title, :description, :status, :bug_image)
  end

  def find_ticket
    @bug_ticket = BugTicket.find(params[:id]).decorate
  end

  def bug_tickets
    current_user.bug_tickets.reverse_order.page(params[:page])
  end
end
