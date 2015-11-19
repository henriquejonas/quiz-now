$(function() {
    bindCheckAnswer()
})

function bindCheckAnswer () {
    $('.question-answer').on('click', checkAnswer)
}

function checkAnswer (e) {
    var other_answers = $(this).parents('.answer-box').first().find('.question-answer')
        , _i = 0
        , _len = 0
        , answer
    if ($(this).prop('checked')) {
        for (_i = 0, _len = other_answers.length; _i < _len; _i++) {
            answer = other_answers[_i]
            if (!$(answer).is($(this))) {
                $(answer).prop('checked', false)
            }
        }
    } else {
        e.preventDefault()
    }
}
