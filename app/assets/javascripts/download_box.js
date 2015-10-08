
$(document).ready(function() {

	$(".generate-album-link").click(function(event){
		event.preventDefault();
		
		$(this).next(".album-link-box").slideToggle();
	});

	$(".generate-track-link").click(function(event){
		event.preventDefault();
		
		$(this).next(".track-link-box").slideToggle();
	});

}); //End of on ready function