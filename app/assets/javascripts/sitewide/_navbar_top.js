$(document).ready(function () {
    //change navbar button class on hover
    $('.nav_bar_button').hover(function () {
        $(this).addClass('active');
    }, function () {
        $(this).removeClass('active');
    });
});