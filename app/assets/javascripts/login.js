$(function() {
    $('#login_link').click(function(event){
        $('#login_prompt_hidden').toggle();
        event.preventDefault();
    });
});
