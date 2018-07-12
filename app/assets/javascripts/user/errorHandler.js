$(document).ready(function(){
    $('#signup-form').on('ajax:success', function(evt, data, status, xhr){
        response = evt["detail"][0];
        console.log("making change")
        if (response["status"] == "error") {
            $('#signup-error-messages').html(
            response["message"]);
        } else if (response["status"] == "success") {
            location.reload()
        }
    });
});