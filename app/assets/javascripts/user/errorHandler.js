$(document).ready(function(){
    $('#signup-form').on('ajax:success', function(evt, data, status, xhr){
        response = evt["detail"][0];
        dataLayer.push({'event': 'signUpSuccess'})
        location.reload()
    }).on('ajax:error', function(evt, xhr, status, error) {
        response = evt["detail"][0];
        $('#signup-error-messages').html(response["message"]);
    });
    
    $('#login-form').on('ajax:success', function(evt, data, status, xhr){
        response = evt["detail"][0]
        if (response["status"] == "success") {
            dataLayer.push({'event': 'loginInSuccess'})
            location.reload()
        }
    }).on('ajax:error', function(evt, xhr, status, error) {
        response = evt["detail"][0]
        $('#login-error-messages').html(
            response);
    });
});