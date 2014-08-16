// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function updatePace() {
	// Defines form input elements
	$distanceInput = $('[name="activity[distance]"]');
	$durationInput = $('[name="activity[duration]"]');
	$paceInput = $('[name="activity[pace]"]');

	// Check if distance input is a number, if it exists, and if the duration input exists
	if ( $.isNumeric($distanceInput.val()) && $distanceInput.val() && $durationInput.val() ) {

		distance = parseFloat($distanceInput.val());
		parsedDuration = $durationInput.val().split(":")

		// Checks length of duration input based on the hh:mm:ss format.
		if ( parsedDuration.length === 3 ) {
			secondsDuration = (+parsedDuration[0]) * 3600 + (+parsedDuration[1]) * 60 + (+parsedDuration[2]);
		} else if ( parsedDuration.length === 2 ) {
			secondsDuration = (+parsedDuration[0]) * 60 + (+parsedDuration[1]);
		} else if ( parsedDuration.length === 1 ) {
			secondsDuration = (+parsedDuration[0]);
		} else {
			console.log('Incorrect input entered in activity[duration]');
		}

		// Calculates mile pace, [s/mile]
		pace = secondsDuration / distance;

		// Converts pace to mm:ss format
		paceArray = [];
		paceArray.push(String(Math.floor(pace / 60)));
		paceSeconds = Math.round((pace % 60)*10)/10;
		if ( paceSeconds < 10 ) {
			paceArray.push("0" + String(paceSeconds));
		} else {
			paceArray.push(String(paceSeconds));
		}
		paceString = paceArray.join(':');
		
		// Sets the pace form input as to the calculated value and disables the input
		$paceInput.val(paceString);
		$paceInput.attr('readonly', true);


	} else {
		// resets the pace form input
		$paceInput.val(null);
		$paceInput.attr('readonly', false);
		console.log('activity[distance] or activity[duration] is invalid.');
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