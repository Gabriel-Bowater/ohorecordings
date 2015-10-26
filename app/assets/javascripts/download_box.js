
$(document).ready(function() {

	//for the download box

	$(".generate-album-link").click(function(event){
		event.preventDefault();
		
		$(this).next(".album-link-box").slideToggle();
	});

	$(".generate-track-link").click(function(event){
		event.preventDefault();
		
		$(this).next(".track-link-box").slideToggle();
	});

	//for the edit user details form

	$("#edit-button").click(function(event){
		event.preventDefault();
		$(".edit-address-form").slideToggle();
	});

}); //End of on ready function