$(document).on('turbolinks:load', function() {
  $('.notification').fadeIn('slow');

  setTimeout(function() {
    $('.notification').fadeOut('slow', function() {
      $(this).remove();
    });
  }, 4000);
});
