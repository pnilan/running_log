function updateActive() {
	var pathArray = location.pathname.split('/');
	$('#' + pathArray[pathArray.length - 1]).addClass('active');
}

	
$(function() {
	console.log('ran on load');
	updateActive();
});