function drawGraph(animation, timeout) {

        var options = { 
            showTooltips: false,
            maintainAspectRatio: false,
            responsive: false, 
            animation: true
        };

        if (animation === false) { options.animation = false };

        var data = {
            labels: ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"],
            datasets: [
                {
                    fillColor: "#e98b39",
                    strokeColor: "#e98b39",
                    data: $("#weekly-chart").data('activities')
                }
            ]
        };


        // draws the weekly chart graph
        var canvas = document.getElementById('weekly-chart');
        var ctx = canvas.getContext("2d");
        ctx.canvas.width = $('#weekly-chart').parent().width();
        ctx.canvas.height = $('#weekly-chart').parent().height();
        console.log("width is: " + ctx.width);
        console.log("height is: " + ctx.height);
        new Chart(ctx).Bar(data, options);

}

$(function() {
    $(window).on('resize', function() {
        drawGraph(false);
    });

    drawGraph(true);
});