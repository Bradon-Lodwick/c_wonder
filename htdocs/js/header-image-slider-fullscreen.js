//holds the height of the window
var height;
//holds the header-image-slider location
var headerImageSlider;
//holds the height of the main-navigation bar
var navbarHeight;

//resizes the height of the image slider to the height of the window
function resizeSlider(){
  //gets window height
  height = $(window).height();
  //gets main-navigation bar height
  navbarHeight = $("#main-navigation").height();
  //gets the location of the header-image-slider
  headerImageSlider = document.getElementById("header-image-slider");
  //checks to see if the navbar is a fixed navbar or default navbar, determining if height needs to be taken into account
  if (!($("#navbar-fixed-top").length)){
    //shifts the slider below the navbar if it is a floating navbar
    $(headerImageSlider).css("margin-top", navbarHeight + "px");
  }
  //sets height after taking into account the navbar type
  $(headerImageSlider).css("height", height - navbarHeight);
}

//loads the resizeSlider function on page load
$(document).ready(function(){
  resizeSlider();
});

//loads the resizeSlider function when the window is resized, to keep it the same size as the window at all times
$(window).resize(function(){
  resizeSlider();
});
