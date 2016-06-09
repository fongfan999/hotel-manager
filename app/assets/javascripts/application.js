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
//= require angular
//= require angular-resource
//= require_tree .
//= require bootstrap-sprockets
//= require chartkick
//= require flat-ui


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
  if (current_path == "/admin") {
  	$("body").css("background-color", "#F1F4F7");
  }

  $(".export").on("click", function() {
    $("li.export").hide();
    $("li#spinner").show();
  });

  $(".search-btn").on("click", function() {
    $("#statistics").hide();
    $("#customers").hide();
    $("#receipts").hide();
    $("#bills").hide();
    $("div#spinner").show();
  });

  // Fix Flat UI
  var tmp = $(".radio").find("label");
  tmp[1].click();
  tmp[0].click();
});


