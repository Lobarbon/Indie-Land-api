$(document).ready(function(){
    const circleType = new CircleType(
        document.getElementById("rotated")
    ).radius(80);
    $(".sub-main").scroll(function(){
        var offset = $(".sub-main").scrollTop();
        offset = offset * 0.4;
        
        $(".circular-text").css({
            "-moz-transform": "rotate("+ offset + "deg)",
            "-webkit-transform": "rotate("+ offset + "deg)",
            "-o-transform": "rotate("+ offset + "deg)",
            "-ms-transform": "rotate("+ offset + "deg)",
            "transform": "rotate("+ offset + "deg)"
        });
    });

    $(".arrow").click(function() {
        $('.sub-main').animate({
            scrollTop: 0
        }, 1000);
    });
});