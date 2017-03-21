module BugTicketsHelper
  def open_bugs_count
    BugTicket.all_open_count
  end
end
