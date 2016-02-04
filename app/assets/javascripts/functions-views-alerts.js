// Closes alerts after successful micropost

$(function() {
		window.setTimeout(function() { 
		$('.alert-success').slideUp(500, function() {
			$(this).remove();
		});
	}, 2500);
});