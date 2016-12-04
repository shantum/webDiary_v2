$(document).ready(function () {

    $(".nav-bar-new-link").click(function(e) {
        $(".nav-bar-new-link-modal").modal('show');
        return false;
    });

});



    // //change navbar button class on hover
    // $('.nav_bar_button').hover(function () {
    //     $(this).addClass('active');
    // }, function () {
    //     $(this).removeClass('active');
    // });

    // $(function() {
    //     var loc = window.location.href; // returns the full URL
    //     if(loc.includes("/user_links/new")) {
    //         $('.nav_user_links_new_button').addClass('active');
    //     }
    // });