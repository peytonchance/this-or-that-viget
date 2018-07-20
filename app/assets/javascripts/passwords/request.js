$(document).ready(function() {
   $("#password-request-form").on('ajax:success', function(evt, data, status, xhr){
      response = evt["detail"][0]
      console.log(response["message"])
      $('#password-request-messages').html(response["message"]);
   }).on('ajax:error', function(evt, xhr, status, error) {
      response = evt["detail"][0]
      $('#password-request-messages').html(response["message"]);
   });
});