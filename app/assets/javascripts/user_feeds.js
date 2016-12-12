$(document).ready(function () {
    $('span.left.floated.save').mouseenter(function() {
        $(this).css('color', 'red')
    })

    $('span.left.floated.save').mouseleave(function() {
        $(this).css('color', 'grey')
    })
});