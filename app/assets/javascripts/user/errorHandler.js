$(document).ready(function(){
    $('#signup-form').on('ajax:success', function(evt, data, status, xhr){
        response = evt["detail"][0];
        if (response["status"] == "error") {
            $('#signup-error-messages').html(
            response["message"]);
        } else if (response["status"] == "success") {
            location.reload()
        }
    });
    
    $('#login-form').on('ajax:success', function(evt, data, status, xhr){
        response = evt["detail"][0]
        if (response["status"] == "success") {
            location.reload()
        }
    }).on('ajax:error', function(evt, xhr, status, error) {
        response = evt["detail"][0]
        $('#login-error-messages').html(
            response);
    });
});