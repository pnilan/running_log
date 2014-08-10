var mobileView = 992;

function getWidth() { return window.innerWidth; }

function detect() {

	if (getWidth() >= mobileView) {
		if ($.cookie('toggle') === undefined) {
			console.log('cookie undefined, large sidebar');
			$('#page-wrapper').addClass('active');
		} else {
			if ($.cookie('toggle') == 'true') {
				$('#page-wrapper').addClass('active');
				console.log('toggle is true, make sidebar big');
			} else {
				$('#page-wrapper').removeClass('active');
				console.log('toggle is false, make sidebar small');
			}
		}
	} else {
		$('#page-wrapper').removeClass('active');
		console.log('width is not greater than 992, make sidebar small');
	}
}

// On document ready

$(document).ready(function() {

	detect();

	// Detect resizing of window and run detect()
	$(window).resize(function() {
		detect();
	});

	// Sidebar toggle
	$('#toggle').click(function(e) {
		e.preventDefault();
		console.log('toggle clicked');
		$('#page-wrapper').toggleClass('active');
		$.cookie('toggle', $('#page-wrapper').hasClass('active'));
	});
});