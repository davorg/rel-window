$( document ).ready(function() {
  $('#start').change(function() {
    var date = new Date($(this).val());
    var now  = new Date;
    var days = Math.floor((now - date) / (1000 * 3600 * 24));
    $('#length').html(days);
    var then = now;
    then.setDate(then.getDate() + days);
    $('#end').html(then.toDateString());
  });
});
