/*
 * This javascript sets the size of the container that holds the front page image
 * to the full size of the browser window.  Scales well with mobile as well
 */

function set_header_height() {
  var wh = $(window).height();
  $("#header-image-container").attr('style', 'height:' + wh + 'px;' + 'margin: auto;');
}
$(document).ready(function() {
  set_header_height();
  $(window).bind('resize', function() { set_header_height(); });
});
