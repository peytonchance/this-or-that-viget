$(document).ready(function() {
   $("#password-reset-form").on('ajax:success', function(evt, data, status, xhr){
      window.location.href = '/';
   }).on('ajax:error', function(evt, xhr, status, error) {
      response = evt["detail"][0]
      $('#password-error-messages').html(response["message"]);
   });
});