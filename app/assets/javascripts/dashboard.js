function updateActive() {
	var pathArray = location.pathname.split('/');
	$('#' + pathArray[pathArray.length - 1]).addClass('active');
}

	
$(function() {
	console.log('ran on load');
	updateActive();
});

function donutShoe(animation) {
	
	var options = {
		showTooltips: false,
		maintainAspectRatio: true,
		responsive: true,
		animation: true,
		segmentShowStroke: false,
		percentageInnerCutout: 70

	};

	if (animation === false) { options.animation = false };

	var data = [
		{
			value: 300,
        	color:"#F7464A",
        	highlight: "#FF5A5E",
        	label: "Miles left"
		},
		{
			value: 100,
			color: "#e98b39",
			highlight: "#e98b39",
			label: "Shoe mileage"
		}
	]
	
	var canvas = document.getElementById('shoe-donut');
	var ctx = canvas.getContext("2d");
	ctx.canvas.width = $('#shoe-donut').parent().width();
	ctx.canvas.height = $('#shoe-donut').parent().height();
	console.log("width is: " + ctx.canvas.width);
	console.log("height is: " + ctx.canvas.height);
	new Chart(ctx).Doughnut(data, options);
}

$(function() {
	$(window).on('resize', function() {
	    if ($('#shoe-donut')) {
	    	donutShoe(false);
	    };
	});

	if ($('#shoe-donut')) {
		donutShoe(true);
	};
});