$('#bug_status').removeClass()
$('#bug_status').addClass('label label-<%=@bug_ticket.status_color(@bug_ticket.status)%>')
$('#bug_status').text('<%=@bug_ticket.status%>')
