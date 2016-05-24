// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap-sprockets
//= require chartkick

$(document).on("ready page:load", function() {
  setTimeout(
  	function() {
	   $(".alert").fadeOut();
	  },
	  5000
	);
});

$(document).ready(function() {
  $('[data-toggle="tooltip"]').tooltip();

  var current_path = window.location.pathname
  console.log(current_path)
  if (current_path != "/") {
  	$(".navbar-default > .container").css("border-bottom", "3px solid #2db893");
  	$(".navbar-default .navbar-nav li a").css("color", "#e74c3c");
  	$(".navbar-default .navbar-toggle .icon-bar").css("background-color", "#e74c3c");
  	$(".navbar-default .navbar-text").css("color", "#fff");
  	$(".navbar-default .navbar-brand").css("color", "#e74c3c");
  	$(".navbar-default .navbar-nav .dropdown-menu li a").css("color", "#fff");
  	$(".navbar-default .navbar-nav .dropdown-menu").css("background-color",
  		"black");
  	$(".navbar-default .navbar-brand").hover(function(){
  		$(this).css("color", "#fff");
  		$(this).css("background-color", "#e74c3c");
    }, function(){
  		$(this).css("color", "#e74c3c");
  		$(this).css("background-color", "#fff");
    });
  }

  $(".export").on("click", function() {
    $(".export").hide();
    $("#spinner").show();
  });
});


