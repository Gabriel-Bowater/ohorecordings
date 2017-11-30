
$(document).ready(function() {

	var playing_audio;
	var last_sample_button;

	$('.js-play').click(function(event){
		event.preventDefault();

		var play_source = $(this).attr('href');
		var pause_playing = false;

		if (playing_audio) {
			playing_source = playing_audio.src;
			last_sample_button.attr('src', '/images/dummyplay.png')
			if (play_source == playing_source){
				pause_playing = true
			}
			playing_audio.pause()
		}

		if (!pause_playing){
			last_sample_button = $(this).children()
			last_sample_button.attr('src', '/images/stop_button.png')
			playing_audio = new Audio(play_source);
			playing_audio.play();
		}else {
			playing_audio = null;
		}

	})


}); //End of on ready function