$(function() {
    function guest_is_coming() {
        return $('input:radio[name="guest[status]"]:checked').val() == 1;
    }

    function set_visibility_based_on_rsvp() {
        if (guest_is_coming()) {
            $('.notes .question').text(notes_coming);
            $('.custom_questions').slideDown();
        } else {
            $('.notes .question').text(notes);
            $('.custom_questions').slideUp();
        }
    }

    // start up behaviour
    if (!guest_is_coming()) {
        $('.custom_questions').hide();
    } else {
        // do nothing
    }
    
    $('.are_you_coming .radio').click(function() {
        set_visibility_based_on_rsvp();
    });
})