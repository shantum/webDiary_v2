$(document).ready(function () {


$('#tokenfield').tokenfield({
    autocomplete: {
        source: ['red','blue','green','yellow','violet','brown','purple','black','white'],
        delay: 100
    },
    showAutocompleteOnFocus: true
})

});