(function() {

    // set up timeout variable
    var t;
    function size(animate) {

        // requires animate to be explicitly called for animation to occur
        if (animate == undefined) {
            animate = false;
        }

        clearTimeout(t);

        t = setTimeout(function() {
            $('#weekly-chart').each(function(i,el) {
                $(el).attr({
                    // sets canvas element's height and width to its parent's height and width
                    "width":$(el).parent().width(),
                    "height":$(el).parent().height()
                });
            });

            // call redraw function to build chart
            redraw(animate);
        }, 30); //the timeout should run after 30 milliseconds
    }

    // on window resize, run the size function with animation turned off
    $(window).on('resize', function() { size(false); });
    function redraw(animation) {

        // default option is to not show tooltips, chart currently glitches with tooltips on
        var options = { showTooltips: false };

        // set animation on or off
        if (!animation) {
            options.animation = false;
        } else {
            options.animation = true;
        }

        // temporary datapoints, add database data later
        var data = {
            labels: ["Mon","Tue","Wed","Thurs","Fri","Sat","Sun"],
            datasets: [
                {
                    label: "Miles this week",
                    fillColor: "#e98b39",
                    strokeColor: "#e98b39",
                    highlightFill: "#F55230",
                    highlightStroke: "#F55230",
                    data: [5.0, 6.0, 10.0, 5.0, 7.0, 12.0, 5.0]
                },
            ]
        }     

       // set up ChartJS weekly chart
        var canvas = document.getElementById('weekly-chart');
        var ctx = canvas.getContext("2d");
        new Chart(ctx).Bar(data, options);
    }

    // draws the first graph
    size(true); 
}());