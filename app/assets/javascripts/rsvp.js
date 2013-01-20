$(function() {
    $('.custom_questions').hide();
    $('.are_you_coming .radio').click(function() {
        var coming = $(this).find('input:checked').val() > 0;
        if (coming) {
            $('.notes .question').text(notes_coming);
            $('.custom_questions').slideDown();
        } else {
            $('.notes .question').text(notes);
            $('.custom_questions').slideUp();
        }
    })
})