$( document ).ready(function() {

  $('#start').change(function() {
    var date = new Date($(this).val());
    var now  = new Date;
    var days = Math.floor((now - date) / (1000 * 3600 * 24));
    $('#length').html(days);
    var then = now;
    then.setDate(then.getDate() + days);
    $('#end').html(then.toDateString());
    localStorage.rel_window_date = date;
  });

  var start_date;
  if (localStorage.rel_window_date) {
    start_date = new Date(localStorage.rel_window_date);
    $('#start').val(start_date.toISOString().substr(0, 10));
    $('#start').change();
  }
});
