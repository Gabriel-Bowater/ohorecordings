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
//= require turbolinks
//= require_tree .

$(document).ready(function() {

	$(".generate").click(function(event){
		alert("money baby")
	});

	var $overlay = $('<div id="overlay"></div>');
	var $image = $('<img>');
	var $caption = $('<p></p>');
	$overlay.append($image);
	$overlay.append($caption);
	$('body').append($overlay);

	$('#album-art').click(function(event){
		event.preventDefault();
		
		var imageLocation = $(this).attr('href');
		$image.attr('src', imageLocation);

		console.log(imageLocation);

		var captionText = $(this).children('img').attr('alt');
		
		$caption.text(captionText);



		$overlay.show();
	});

	$overlay.click(function(){
		$overlay.hide();
	});
}); //End of on ready function