$(document).on('turbolinks:load', function() {
  $('.notification').slideDown('slow');

  setTimeout(function() {
    $('.notification').slideUp('slow', function() {
      $(this).remove();
    });
  }, 6000);
});
