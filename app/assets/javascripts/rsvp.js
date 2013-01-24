$(function() {
    function guest_is_coming() {
        return $('input:radio[name="guest[status]"]:checked').val() == 1;
    }

    function set_visibility_based_on_rsvp(animate) {
        if (guest_is_coming()) {
            $('.notes .question').text(notes_coming);
            if (animate) {
                $('.custom_questions').slideDown();
            } else {
                $('.custom_questions').show();
            }
        } else {
            $('.notes .question').text(notes);
            if (animate) {
                $('.custom_questions').slideUp();
            } else {
                $('.custom_questions').hide();
            }
        }
    }

    // start up behaviour
    set_visibility_based_on_rsvp(false);
    
    $('.are_you_coming .radio').click(function() {
        set_visibility_based_on_rsvp(true);
    });
})