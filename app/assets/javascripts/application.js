//= require jquery
//= require jquery_ujs
//= require s3_direct_upload
//= require_tree .


function noSample(){
  alert("No sample available, sorry.");

}


$(document).ready(function() {

	if (window.location.pathname == "/"){
		$("#background_div").css("background-color", "#261c00")
	}


}); //End of on ready function