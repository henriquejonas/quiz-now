$(function() {
    $('.alert-auto-hide').parent('.alert-container').fadeOut(15000)
    $('.field_with_errors').parent('.form-group').addClass('has-error')
    $('.has-error:first').find('input').focus()
})