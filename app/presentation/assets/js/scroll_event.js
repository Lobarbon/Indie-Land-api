var position = 10; 
$(document).ready(function(){
    // header 背景平滑滾動
    $("body").scroll(function() {
        var scroll = $("body").scrollTop();
        if(scroll > position) {
            console.log('scrollDown');
            position = 1000;
            $("body").animate({
                scrollTop: 1000
            }, 1000);
            position = 2000;
        }
        if(scroll == 0){
            position = 10;
        }
    });

    $("body").scroll(function(){
        var body_scroll_top = $("body").scrollTop();
        if(body_scroll_top > 100){
            $("#li1").fadeIn("slow", function(){
                $("#li2").fadeIn("slow", function(){
                    $("#li3").fadeIn("slow", function(){
                        $("#li4").fadeIn("slow");
                    });
                });
            });
        }else{
            $("#li1").css("display", "none");
            $("#li2").css("display", "none");
            $("#li3").css("display", "none");
            $("#li4").css("display", "none");
        }

    });
    $("#li1").click(function() {
        $('html, body').animate({
            scrollTop: $("body").offset().top
        }, 1000);
    });

    $(".mic").click(function() {
        $('html, body').animate({
            scrollTop: $(".sub-main").offset().top
        }, 1000);
    });
});