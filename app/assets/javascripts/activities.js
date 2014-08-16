// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function updatePace() {
	$distanceInput = $('[name="activity[distance]"]');
	$durationInput = $('[name="activity[duration]"]');
	$paceInput = $('[name="activity[pace]"]');

	if ( $.isNumeric($distanceInput.val()) && $distanceInput.val() && $durationInput.val() ) {

		distance = parseFloat($distanceInput.val());
		parsed = $durationInput.val().split(":")

		if ( parsed.length === 3 ) {
			seconds = (+parsed[0]) * 3600 + (+parsed[1]) * 60 + (+parsed[2]);
		} else if ( parsed.length === 2 ) {
			seconds = (+parsed[0]) * 60 + (+parsed[1]);
		} else if ( parsed.length === 1 ) {
			seconds = (+parsed[0]);
		} else {
			console.log('Incorrect input entered in activity[duration]');
		}

		pace = seconds/distance;
		paceArray = [];
		paceArray.push(String(Math.floor(pace/60)));
		paceSeconds = parseInt(pace % 60);
		if ( paceSeconds < 10 ) {
			paceArray.push("0" + String(paceSeconds));
		} else {
			paceArray.push(String(paceSeconds));
		}
		paceString = paceArray.join(':');
		
		$paceInput.val(paceString);
		$paceInput.attr('readonly', true);


	} else {
		$paceInput.val(null);
		$paceInput.attr('readonly', false);
		console.log('activity[distance] does not exist or is not numeric.');
	}
}

$(function() {
	$duration = $('[name="activity[duration]"]');
	$distance = $('[name="activity[distance]"]');

	$duration.on('input', function() {
		updatePace();
	});

	$distance.on('input', function() {
		updatePace();
	});
});